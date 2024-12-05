C*  This file is part of MED.
C*
C*  COPYRIGHT (C) 1999 - 2023  EDF R&D, CEA/DEN
C*  MED is free software: you can redistribute it and/or modify
C*  it under the terms of the GNU Lesser General Public License as published by
C*  the Free Software Foundation, either version 3 of the License, or
C*  (at your option) any later version.
C*
C*  MED is distributed in the hope that it will be useful,
C*  but WITHOUT ANY WARRANTY; without even the implied warranty of
C*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
C*  GNU Lesser General Public License for more details.
C*
C*  You should have received a copy of the GNU Lesser General Public License
C*  along with MED.  If not, see <http://www.gnu.org/licenses/>.
C*

C******************************************************************************
C * Tests for struct element module
C *
C *****************************************************************************
      program MEDstructElement1
C     
      implicit none
      include 'med.hf'
C
C     
      integer cret
      integer*8 fid

      character*64  fname
      parameter (fname = "Unittest_MEDstructElement_1.med")
      character*64  mname1, mname2, mname3
      parameter (mname1 = "model name 1")
      parameter (mname2 = "model name 2")
      parameter (mname3 = "model name 3")
      integer dim1, dim2, dim3
      parameter (dim1=2)
      parameter (dim2=2)
      parameter (dim3=2)
      character*64  smname1
      parameter (smname1=MED_NO_NAME)
      character*64  smname2
      parameter (smname2="support mesh name")
      integer setype1
      parameter (setype1=MED_NONE)
      integer setype2
      parameter (setype2=MED_NODE)
      integer setype3
      parameter (setype3=MED_CELL)
      integer sgtype1
      parameter (sgtype1=MED_NO_GEOTYPE)
      integer sgtype2
      parameter (sgtype2=MED_NO_GEOTYPE)
      integer sgtype3
      parameter (sgtype3=MED_SEG2)
      integer mtype1,mtype2,mtype3
      integer sdim1
      parameter (sdim1=2)
      character*200 description1
      parameter (description1="support mesh1 description")
      character*16 nomcoo2D(2)
      character*16 unicoo2D(2)
      data  nomcoo2D /"x","y"/, unicoo2D /"cm","cm"/
      real*8 coo(2*3)
      data coo / 0.0, 0.0, 1.0,1.0, 2.0,2.0 /
      integer nnode
      parameter (nnode=3)
      integer nseg2
      parameter (nseg2=2)
      integer seg2(4)
      data seg2 /1,2, 2,3/
C 
C
C     file creation
      call mfiope(fid,fname,MED_ACC_CREAT,cret)
      print *,'Open file',cret
      if (cret .ne. 0 ) then
         print *,'ERROR : file creation'
         call efexit(-1)
      endif 
C
C
C     first struct element model creation
      call msecre(fid,mname1,dim1,smname1,setype1,
     &            sgtype1,mtype1, cret)
      print *,'Create struct element',mtype1, cret
      if ((cret .ne. 0) .or. (mtype1 .lt. 0) ) then
         print *,'ERROR : struct element creation'
         call efexit(-1)
      endif 
C
C
C     support mesh creation : 2D
      call msmcre(fid,smname2,dim2,dim2,description1,
     &            MED_CARTESIAN,nomcoo2D,unicoo2D,cret)
      print *,'Support mesh creation : 2D space dimension',cret
      if (cret .ne. 0 ) then
         print *,'ERROR : support mesh creation'
        call efexit(-1)
      endif   
c
      call mmhcow(fid,smname2,MED_NO_DT,MED_NO_IT, 
     &            MED_UNDEF_DT,MED_FULL_INTERLACE, 
     &            nnode,coo,cret)
c
      call mmhcyw(fid,smname2,MED_NO_DT,MED_NO_IT,
     &            MED_UNDEF_DT,MED_CELL,MED_SEG2, 
     &            MED_NODAL,MED_FULL_INTERLACE,
     &            nseg2,seg2,cret)
C
C
C     second struct element model creation
      call msecre(fid,mname2,dim2,smname2,setype2,
     &            sgtype2,mtype2,cret)
      print *,'Create struct element',mtype2, cret
      if ((cret .ne. 0) .or. (mtype2 .lt. 0) ) then
         print *,'ERROR : struct element creation'
         call efexit(-1)
      endif  
C
C
C     third struct element model creation
      call msecre(fid,mname3,dim3,smname2,setype3,
     &            sgtype3,mtype3,cret)
      print *,'Create struct element',mtype3, cret
      if ((cret .ne. 0) .or. (mtype3 .lt. 0) ) then
         print *,'ERROR : struct element creation'
         call efexit(-1)
      endif  
C
C
C     close file
      call mficlo(fid,cret)
      print *,'Close file',cret
      if (cret .ne. 0 ) then
         print *,'ERROR :  close file'
         call efexit(-1)
      endif  
C
C
C
      end

