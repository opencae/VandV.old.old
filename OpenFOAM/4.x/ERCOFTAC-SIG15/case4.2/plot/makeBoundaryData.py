#!/usr/bin/env python

import re
import os

turbulentFiles=['k','epsilon','omega']

x0='-0.372028'
x1='-0.372028'
z0='0'
z1='0.005'


turbulentMin=1e-5

n=0
y=[0]
U=[0]
V=[0]
u2=[0]
v2=[0]
uv=[0]
turbulent=[[0],[0],[0]]
Uold=0
yold=0
for line in open('exptData/ch000.dat','r'):
   n+=1
   if n<=4:
      continue
   elif n>=21:
      break
   data=map(float, re.findall(r"[0-9.-]+",line))
   ytmp=data[0]/1000
   Utmp=data[1]
   u2tmp=data[2]/100
   Vtmp=data[3]
   v2tmp=data[4]/100
   uvtmp=data[5]/100

   y.append(ytmp)
   U.append(Utmp)
   u2.append(u2tmp)
   V.append(Vtmp)
   v2.append(v2tmp)
   uv.append(uvtmp)

   k=u2tmp+v2tmp*2
   turbulent[0].append(k)

   epsilon=-uvtmp*(Utmp-Uold)/(ytmp-yold)
   turbulent[1].append(epsilon)

   # omega
   if k>0:
      turbulent[2].append(epsilon/k)
   else:
      turbulent[2].append(0.0)


turbulentOld=[turbulentMin,turbulentMin,turbulentMin]
for i in range(len(y)-2,-1,-1):
   for j in range(3):
      if turbulent[j][i]<turbulentMin:
         turbulent[j][i]=turbulentOld[j]
      turbulentOld[j]=turbulent[j][i]

for i in range(len(y)-2,-1,-1):
   y.append(0.17-y[i])
   U.append(U[i])
   V.append(V[i])
   for j in range(3):
      turbulent[j].append(turbulent[j][i])

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
for ytmp in y:
   file.write('('+x0+' '+repr(ytmp)+' '+z0+')\n')
file.write('// max\n')
for ytmp in y:
   file.write('('+x1+' '+repr(ytmp)+' '+z1+')\n')
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
   file.write('('+repr(Utmp)+' 0 0)\n')
file.write('// max\n')
for Utmp in U:
   file.write('('+repr(Utmp)+' 0 0)\n')
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
      file.write(repr(tmp)+'\n')
   file.write('// max\n')
   for tmp in turbulent[i]:
      file.write(repr(tmp)+'\n')
   file.write(')\n')
   file.write(commonFooter)
   file.close()

