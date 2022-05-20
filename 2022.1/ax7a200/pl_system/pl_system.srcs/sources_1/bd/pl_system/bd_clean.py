#!/usr/bin/python3

#-------------------------------------------------------------------------------
# MIT License
#
# Copyright (c) 2021 homelith
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# bd_clean.py
#
# when you rename some `old_name` modules to `new_name` on board design, you may result `ip` dir on board design still have `old_name/old_name.xci` ip file.
# this program rename old_name.xci files into random char based names while keeping synthesizable the board design.
#
# typical usage :
# - since this script includes destructive manipulation such as file rename / remove, *BACK UP ENTIRE PROJECT BEFORE USE* .
# - put bd_clean.py on the same depth of {target_design_name}.bd
# - run `python3 bd_clean.py {target_design_name}`
# - you will get synthesizable board design directory structure where ip/{some_ip_name}/{some_ip_name}.xci renamed with ip/{target_design_name}_{random_chars}/{target_design_name}_{random_chars}.xci
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# known issue
# - this script does not support ips with subdirectories, they are gracefully skipped
# - automatic generated axi translator ips such as `auto_xx_xx` are re-generated when board design reopened by vivado
#   (its normally ok because vivado automatically clean up old renamed `auto_xx_xx` modules on regeneration)
#-------------------------------------------------------------------------------

import sys
import os
import argparse
import pprint
import json
import collections
import random
import re
import string
import shutil
import xml.etree.ElementTree as ElementTree

# bd json & bxml XML object to be manipulated
global mode
global design_name
global bd_dict
global bxml_tree

# find XML record which points xci filepath
def find_xci_path_from_bxml(xci_path):
	for tag in bxml_tree.findall(".//*[@Type='IP']"):
		if xci_path == tag.attrib["Name"]:
			return tag

# search specific "xci_name" and return True if found
def find_xci_name_from_bd_dict(sub_dict, xci_name):
	ret = False
	if isinstance(sub_dict, collections.OrderedDict):
		for key in sub_dict.keys():
			if key == "xci_name" and sub_dict[key] == xci_name:
				ret = True
			else:
				ret = find_xci_name_from_bd_dict(sub_dict[key], xci_name)
	return ret

# search specific "xci_path" and return True if found
def find_xci_path_from_bd_dict(sub_dict, xci_path):
	ret = False
	if isinstance(sub_dict, collections.OrderedDict):
		for key in sub_dict.keys():
			if key == "xci_path" and sub_dict[key] == xci_path:
				ret = True
			else:
				ret = find_xci_path_from_bd_dict(sub_dict[key], xci_path)
	return ret

# replace "xci_name" with "{design_name}_{7 character randomized string}" on bd,
# replace "<File name="" ... >" attribute with 7 char string on bxml
# rename xci file and directory name under 'ip/' with 7 char string
# 7 chars are selected from UPPERCASE ascii & digits according to another Vivado based name generation
def sanitize_xci(bd_xci_record):

	# get xci filepath and confirm the path valid
	bxml_xci_record = None
	if mode == "legacy":
		bxml_xci_record = find_xci_path_from_bxml("ip/" + bd_xci_record["xci_name"] + "/" + bd_xci_record["xci_name"] + ".xci")
		if bxml_xci_record == None:
			print("warn : bxml filepath record not found for '%s.xci', skipping..." % bd_xci_record[""], end="\n", file=sys.stderr)
			return

	org_xci_name = bd_xci_record["xci_name"]

	org_xci_path = ""
	if mode == "legacy":
		org_xci_path = bxml_xci_record.attrib["Name"]
	else:
		org_xci_path = bd_xci_record["xci_path"]
	if not os.path.isfile(org_xci_path):
		print("warn : bxml filepath record '%s' is not valid, skipping..." % bxml_xci_record.attrib["Name"], end="\n", file=sys.stderr)
		return

	org_xci_dir = os.path.dirname(org_xci_path)
	org_xcixml_path = os.path.splitext(org_xci_path)[0] + ".xml"

	# skip renaming if already named with 7 char format
	pattern = re.compile("^" + design_name + "_[A-Z0-9]{7}$")
	if pattern.match(org_xci_name) != None:
		print("log : ip '%s' seemed to be already renamed with this script, skipping..." % org_xci_name, end="\n", file=sys.stderr)
		return

	# check if there are xci and xml file only and no submodules
	# currently submodule renaming is not supported
	if sum(os.path.exists(os.path.join(org_xci_dir, name)) for name in os.listdir(org_xci_dir)) != 2:
		print("log : '%s' includes submodules and not supported, skipping..." % org_xci_dir, end="\n", file=sys.stderr)
		return

	# make new 7 chars pathname and check if already exists
	new_xci_name = ""
	new_xci_dir = ""
	new_xci_path = ""
	new_xcixml_path = ""
	while True:
		new_xci_name = design_name + "_" + ''.join(random.choices(string.ascii_uppercase + string.digits, k=7))
		if find_xci_name_from_bd_dict(bd_dict, new_xci_name):
			continue
		new_xci_dir = "ip/" + new_xci_name
		if os.path.isdir(new_xci_dir):
			continue
		new_xci_path = "ip/" + new_xci_name + "/" + new_xci_name + ".xci"
		if mode == "legacy":
			if find_xci_path_from_bxml(new_xci_path) != None:
				continue
		else:
			if find_xci_path_from_bd_dict(bd_dict, new_xci_path):
				continue
		if os.path.isfile(new_xci_path):
			continue
		new_xcixml_path = "ip/" + new_xci_name + "/" + new_xci_name + ".xml"
		if mode == "legacy" and os.path.isfile(new_xcixml_path):
			continue
		break

	# move xci file
	os.makedirs(new_xci_dir, mode=511)
	shutil.move(org_xci_path, new_xci_path)
	if mode == "legacy":
		shutil.move(org_xcixml_path, new_xcixml_path)
	shutil.rmtree(org_xci_dir)

	# rename records
	bd_xci_record["xci_name"] = new_xci_name
	if mode == "legacy":
		bxml_xci_record.attrib["Name"] = new_xci_path
	else:
		bd_xci_record["xci_name"] = new_xci_path
	print("log : ip '%s' has renamed to '%s'" % (org_xci_name, new_xci_name), end="\n", file=sys.stderr)

# scan "xci_name" object and call sanitizer
def recurr_scan_xci(sub_dict):
	if isinstance(sub_dict, collections.OrderedDict):
		for key in sub_dict.keys():
			if key == "xci_name":
				sanitize_xci(sub_dict)
			else:
				recurr_scan_xci(sub_dict[key])

if __name__ == "__main__":
	# parse arguments and validate filepaths
	parser = argparse.ArgumentParser(description="rename old_name.xci files into random char based names with keeping synthesizable")
	parser.add_argument("-m", "--mode", type=str, default="default", help="specify `legacy` to process board design 2020.1 or before")
	parser.add_argument("design_name", type=str, default="", help="design basename (e.g. pl_system)")
	parser.add_argument("bd_path", type=str, nargs="?", default="", help="bd filepath (default : {./{design basename}.bd})")
	parser.add_argument("bxml_path", type=str, nargs="?", default="", help="bxml filepath (only used in legacy mode) (default : {./{design basename}.bxml})")
	args = parser.parse_args()

	design_name = args.design_name

	if args.mode != "default" and args.mode != "legacy":
		print("error : mode '%s' is unrecognized" % args.mode, end="\n", file=sys.stderr)
		sys.exit(1)
	mode = args.mode

	if args.bd_path == "":
		args.bd_path = "./" + args.design_name + ".bd"
	if not os.path.isfile(args.bd_path):
		print("error : bd filepath '%s' specified but not found" % args.bd_path, end="\n", file=sys.stderr)
		sys.exit(1)

	if args.bxml_path == "":
		args.bxml_path = "./" + args.design_name + ".bxml"
	if mode == "legacy" and not os.path.isfile(args.bxml_path):
		print("error : bxml filepath '%s' specified but not found" % args.bxml_path, end="\n", file=sys.stderr)
		sys.exit(1)

	print("info : run program with mode = '%s', design_name = '%s', bd_path = '%s', bxml_path = '%s'" % (args.mode, args.design_name, args.bd_path, args.bxml_path), end="\n", file=sys.stderr)

	# open bd file and unmarshal as json
	bd_fp = open(args.bd_path, "r")
	bd_dict = json.load(bd_fp, object_pairs_hook = collections.OrderedDict)
	bd_fp.close()

	# open bxml file and unmarshal as XML (legacy)
	if mode == "legacy":
		bxml_tree = ElementTree.parse(args.bxml_path)

	# scan bd and replace xci name
	recurr_scan_xci(bd_dict)

	# write to bd & bxml file
	bd_fp = open(args.bd_path, "w")
	json.dump(bd_dict, bd_fp, sort_keys=False, indent=2)
	bd_fp.close()

	# write to bxml file (legacy mode)
	if mode == "legacy":
		bxml_tree.write(args.bxml_path)

