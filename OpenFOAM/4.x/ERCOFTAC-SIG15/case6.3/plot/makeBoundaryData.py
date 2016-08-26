#!/usr/bin/env python

import re
import os

turbulentFiles=['k','epsilon','omega']

x0=-0.075
x1=-0.075
y0=0
y1=0.0875
z0=0
z1=0.05

space = re.compile(r'\s+')

y=[z0]
u=[0]
uu=[0]
vv=[0]
uv=[0]
for line in open('expData/mu__0101.dat','r'):
   if line[0]=='#':
      continue
   data=space.split(line.strip())
   y.append(float(data[0])*1e-3)
   u.append(float(data[1]))
for line in open('expData/fuu_0101.dat','r'):
   if line[0]=='#':
      continue
   data=space.split(line.strip())
   uu.append(float(data[1]))
for line in open('expData/fvv_0101.dat','r'):
   if line[0]=='#':
      continue
   data=space.split(line.strip())
   vv.append(float(data[1]))
for line in open('expData/fuv_0101.dat','r'):
   if line[0]=='#':
      continue
   data=space.split(line.strip())
   uv.append(float(data[1]))

y.append(z1)
u.append(0)
uu.append(0)
vv.append(0)
uv.append(0)

#print 'y=',y
#print 'u=',u
#print 'uu=',uu
#print 'vv=',vv
#print 'uv=',uv

# turbulent fields
turbulent=[[],[],[]]
print len(u)
epsilonOld=1e-3
for i in range(len(u)):
   if i==0:
      dudy=(u[i+1]-u[i])/(y[i+1]-y[i])
   elif i==(len(u)-1):
      dudy=(u[i]-u[i-1])/(y[i]-y[i-1])
   else:
      dudy=(u[i+1]-u[i-1])/(y[i+1]-y[i-1])

   k=0.5*(uu[i]*uu[i]+vv[i]*vv[i])
   turbulent[0].append(k)

   epsilon=-uv[i]*dudy
   if epsilon<=0:
      epsilon=epsilonOld
   else:
      epsilonOld=epsilon
   turbulent[1].append(epsilon)

   if k>0:
      omega=epsilon/k
   else:
      omega=0
   turbulent[2].append(omega)

# common
commonHeader = """\
/*--------------------------------*- C++ -*----------------------------------*\
| =========                 |                                                 |
| \\      /  F ield         | OpenFOAM: The Open Source CFD Toolbox           |
|  \\    /   O peration     | Version:  4.0                                   |
|   \\  /    A nd           | Web:      www.OpenFOAM.org                      |
|    \\/     M anipulation  |                                                 |
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
   file.write('('+repr(x0)+' '+repr(y0)+' '+repr(ytmp)+')\n')
file.write('// max\n')
for ytmp in y:
   file.write('('+repr(x1)+' '+repr(y1)+' '+repr(ytmp)+')\n')
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
file.write(repr(len(u)*2)+'\n')
file.write('(\n')
file.write('// min\n')
for utmp in u:
   file.write('('+repr(utmp)+' 0 0)\n')
file.write('// max\n')
for utmp in u:
   file.write('('+repr(utmp)+' 0 0)\n')
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
