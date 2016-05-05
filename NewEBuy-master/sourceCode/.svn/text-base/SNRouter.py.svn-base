#!/usr/bin/python

from biplist import *


plistSource = "SuningEBuy/Resources/Plist/SNRouter.plist"

def vsort(x,y):
    try:
        xi = float(x)
        try:
            yi = float(y)
            if xi < yi :
                return -1;
            elif xi == yi:
                return 0;
            else:
                return 1;
        except:
            return 1;
    except:
        return -1;

try:
    plist = readPlist(plistSource)

    resultStr = ""
    keys = plist.keys()
    keys.sort(cmp=vsort)
    for k in keys:
        value = plist[k]
        resultStr = resultStr + "//" + k + "\n"
        resultStr = resultStr + "- (void)" + value + "(SNRouterObject *)obj\n{\n\n}\n\n"

    FILE = open("SNRouterResult.txt","w")
    FILE.write(resultStr)
except (InvalidPlistException, NotBinaryPlistException), e:
    print "Not a plist:", e