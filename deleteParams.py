#!/usr/bin/env python

"""
Author : Peter Slaughter
Date   : Feb. 2013
Purpose: Maintain database of RHESSys runtime parameters
"""

import commands, csv, getopt, os, re, string, sys, time
from datetime import datetime
from datetime import date
import logging
import operator
import shutil
from string import Template
import time
import tempfile
import sqlite3
import rhessys.constants as rpc
from rhessys.params import paramDB

paramFileRegex = re.compile('^\s*([\w.-]+)\s*([\w.-]+)#*.*$')
csvFileRegex = re.compile('^\s*(\w+)\s*,(\w+).*$')

def usage():
    print''
    print 'Program: %s' % sys.argv[0]
    print 'Purpose: Search the RHESsys parameter database and output the results'
    print ''
    print 'Syntax:'
    print ''
    print '  %s --class=<class name> [--comment=<comment string>] [--endDatetime=<datetime>] [--genus=<genus name>] --location=<location name> --reference=<user comment>] [--searchType=<hierarchical | constrained>] [--species=<species name>] [--startDatetime=<datetime>] [--user=<user name>] --verbose' % sys.argv[0]
    print ''
    print '    where:'
    print '      --class=<name>: any name that can uniquely identify a set of parameters' 
    print '             - example class names might be "Western Hemlock", "Ponderosa Pine, eastern Sierra"'
    print '      --comment=<comment string>: this can be any comment that will be used to search for matching records in the parameter database.'
    print '      --endDatetime=<datetime>: select parameters that were inserted into the database before the specified datetime. Datetime can'
    print '        be specified in one of the formats: "YYYY-MM-DD", "YYYY-MM-DD HH:MM" or "YYYY-MM-DD HH:MM:SS", for example "2013-04-15 10:25:00"'
    print '      --genus=<genus name>: the name of a genus that will be used for searching'
    print '      --location=<location name>: the location to search for, e.g. "Orgeon"'
    print '      --reference=<reference string>: this can be any reference (citation) that will be used to search for matching records in the parameter database.'
    print '      --searchType=<hierarchical | constrained>: perform a hierarchical or constrained search'
    print '      --species=<species name">: the name of a genuse that will be used for searching'
    print '      --startDatetime=<datetime>: select parameters that were inserted into the database after the specified datetime. Datetime can'
    print '        be specified in one of the formats: "YYYY-MM-DD", "YYYY-MM-DD HH:MM" or "YYYY-MM-DD HH:MM:SS", for example "2013-04-15 10:25:00"'
    print '      --user=<user name>: the name of the person that will be used for searching'
    print '      --userdef=<user defined string>: a user defined string that will be used for searching'
    print ''
    print '    for example:'
    print ''
    print '        %s --searchType=constrained --class="Red Alder" --param="epc" --startDatetime="2013-04-16" ' % sys.argv[0]
    print ''
    
if __name__ == '__main__':

    comment = None
    className = None
    classType = None
    endDatetimeStr = None
    startDatetimeStr = None
    location = None
    param = None
    genus = None
    reference = None
    searchType = None
    species = None
    user = None
    verbose = False

    # Parse command line
    try:
        opts, args = getopt.getopt(sys.argv[1:], "hv", ["class=", "comment=", "startDatetime=", "endDatetime=", "genus=", "location=", "output=", "param=", "reference=", "species=", "type=", "searchType=", "user=", "verbose"]) 
    except getopt.GetoptError:
        # print help information and exit:
        print 'Error in command line:\n %s' % sys.argv
        print 'exception type= ', sys.exc_type
        print 'exception value= ', sys.exc_value
        usage()
        sys.exit(1)

    for o, a in opts:
        if o in ("-h", "--help"):
            usage()
            sys.exit()
        elif o in ("--startDatetime"):
            startDatetimeStr = a
        elif o in ("--endDatetime"):
            endDatetimeStr = a
        elif o in ("--comment"):
            comment = a
        elif o in ("--genus"):
            genus = a
        elif o in ("--species"):
            species = a
        elif o in ("--type"):
            classType = a
        elif o in ("--location"):
            location = a
        elif o in ("--class"):
            className = a
        elif o in ("--param"):
            param = a
        elif o in ("--reference"):
            reference = a
        elif o in ("--searchType"):
            searchType = a
            if (searchType not in rpc.SEARCH_TYPES):
                msg = "Invalid search type %s" % searchType
                usage()
                raise RuntimeError, msg
        elif o in ("-u", "--user"):
            user = a
        elif o in ("-v", "--verbose"):
            verbose = True

    DBobj = paramDB()
    DBobj.delete(searchType, classType, className, location, param, genus, species, startDatetimeStr, endDatetimeStr, user, reference)
