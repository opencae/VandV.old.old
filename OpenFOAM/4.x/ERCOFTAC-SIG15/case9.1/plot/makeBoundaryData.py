#!/usr/bin/env python

import re
import os

turbulentFiles=['k','epsilon','omega']

x0='-1'
x1='1'
z0='0'
z1='0'

n=0
r=[]
U=[]
R=[]
turbulent=[[],[],[]]
for line in open('exptData/inlet.dat','r'):
   n+=1
   if n<=3:
      continue
   data=re.findall(r"[0-9].[0-9][0-9][0-9]E[+-][0-9][0-9]",line)
   r.append(data[0])
   U.append([data[1],data[2],data[3]])
   R.append([data[4],data[7],data[8],data[5],data[9],data[6]])
   k=0.5*(float(data[4])+float(data[5])+float(data[6]))
   epsilon=data[10]
   turbulent[0].append(repr(k))
   turbulent[1].append(epsilon)
   if k>0:
      turbulent[2].append(repr(float(epsilon)/k))
   else:
      turbulent[2].append('0')

# common
commonHeader = """\
/*--------------------------------*- C++ -*----------------------------------*\\
| =========                 |                                                 |
| \\\\      /  F ield         | OpenFOAM: The Open Source CFD Toolbox           |
|  \\\\    /   O peration     | Version:  2.2.2                                 |
|   \\\\  /    A nd           | Web:      www.OpenFOAM.org                      |
|    \\\\/     M anipulation  |                                                 |
\*---------------------------------------------------------------------------*/
"""
commonFooter = """\

// ************************************************************************* //
"""

# points
header = """\
FoamFile
{
    version     2.0;
    format      ascii;
    class       vectorField;
    object      points;
}
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

(
"""
patchName='inlet'
os.mkdir('../constant/boundaryData')
os.mkdir('../constant/boundaryData/'+patchName)
os.mkdir('../constant/boundaryData/'+patchName+'/0')
file=open('../constant/boundaryData/'+patchName+'/points','w')
file.write(commonHeader)
file.write(header)
file.write('// min\n')
for rtmp in r:
   file.write('('+x0+' '+rtmp+' '+z0+')\n')
file.write('// max\n')
for rtmp in r:
   file.write('('+x1+' '+rtmp+' '+z0+')\n')
file.write(')\n')
file.write(commonFooter)
file.close()

   # U
header = """\
FoamFile
{
    version     2.0;
    format      ascii;
    class       vectorAverageField;
    object      values;
}
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

// Average
(0 0 0)

// Data on points
"""

file=open('../constant/boundaryData/'+patchName+'/0/U','w')
file.write(commonHeader)
file.write(header)
file.write(repr(len(U)*2)+'\n')
file.write('(\n')
file.write('// min\n')
for Utmp in U:
   file.write('(')
   for Ui in Utmp:
      file.write(' '+Ui)
   file.write(')\n')
file.write('// max\n')
for Utmp in U:
   file.write('(')
   for Ui in Utmp:
      file.write(' '+Ui)
   file.write(')\n')
file.write(')\n')
file.write(commonFooter)
file.close()

   # R
header = """\
FoamFile
{
    version     2.0;
    format      ascii;
    class       symmTensorAverageField;
    object      values;
}
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

// Average
(0 0 0 0 0 0)

// Data on points
"""

file=open('../constant/boundaryData/'+patchName+'/0/R','w')
file.write(commonHeader)
file.write(header)
file.write(repr(len(R)*2)+'\n')
file.write('(\n')
file.write('// min\n')
for Rtmp in R:
   file.write('(')
   for Ri in Rtmp:
      file.write(' '+Ri)
   file.write(')\n')
file.write('// max\n')
for Rtmp in R:
   file.write('(')
   for Ri in Rtmp:
      file.write(' '+Ri)
   file.write(')\n')
file.write(')\n')
file.write(commonFooter)
file.close()

   # turbulent File
header = """\
FoamFile
{
    version     2.0;
    format      ascii;
    class       scalarAverageField;
    object      values;
}
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

// Average
0

// Data on points
"""

for i in range(len(turbulentFiles)):
   file=open('../constant/boundaryData/'+patchName+'/0/'+turbulentFiles[i],'w')
   file.write(commonHeader)
   file.write(header)
   file.write(repr(len(turbulent[i])*2)+'\n')
   file.write('(\n')
   file.write('// min\n')
   for tmp in turbulent[i]:
      file.write(tmp+'\n')
   file.write('// max\n')
   for tmp in turbulent[i]:
      file.write(tmp+'\n')
   file.write(')\n')
   file.write(commonFooter)
   file.close()

