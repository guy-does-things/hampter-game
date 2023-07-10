
# import required module
import os
import sys

itemnames = [
	# misc
	"HPUP",
	# gating
	"STOMP",
	"WATERBREATHING",
	"PLATFORM",
	"SPEEDBOOSTER",

	"SOULBLAST",
	"RISINGSLASH",
	"BROKENASSSLASH",
	"PIPEBOMB",
	"BREAST",
	"BLADEUP"
]


# iterate over files in
# that directory
pydec = 0
replace = "item_id = 1"



for i,filename in enumerate(os.listdir(os.getcwd())):
    if filename.endswith(".py"):
        pydec = 1
        continue


    itemd = 1<<(i-pydec)
    replaceditem = replace.replace("1",str(itemd))
    newfn = itemnames[i-pydec]+"."+filename.split(".")[-1]
    filedata = ""
    with open(filename,"r") as itemdata:
        filedata = itemdata.read()
        filedata = filedata.replace(replace,replaceditem)

        
        
    with open(filename,"w") as itemdata:
        itemdata.write(filedata)        

    # checking if it is a file
    if os.path.isfile(filename):
        os.rename(filename,newfn)

        
print("done!, press enter to quit")   
input()        
