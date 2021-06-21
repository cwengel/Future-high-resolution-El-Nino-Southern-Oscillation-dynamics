#!/bin/sh
set -xe

timestep=80

monthlist="01 02 03 04 05 06 07 08 09 10 11 12"

for i in {1..80} ; do
 for j in ${monthlist} ; do
  if [ ${i} = 1 ] && [ ${j} = "01" ] ; then
  cdo seltimestep,${i} /home/cwengel/_proj/CESM_data_processed_pop62_lagroff/BJ_index/output_from_shscript/m${j}/QNET.mon.1x1.east.fldmean.a.nc QNET.mon.1x1.east.fldmean.a.all_m.nc
  else
  cdo cat -seltimestep,${i} /home/cwengel/_proj/CESM_data_processed_pop62_lagroff/BJ_index/output_from_shscript/m${j}/QNET.mon.1x1.east.fldmean.a.nc QNET.mon.1x1.east.fldmean.a.all_m.nc
  fi
 done
done

for i in {1..80} ; do
 for j in ${monthlist} ; do
  if [ ${i} = 1 ] && [ ${j} = "01" ] ; then
  cdo seltimestep,${i} /home/cwengel/_proj/CESM_data_processed_pop62_lagroff/BJ_index/output_from_shscript/m${j}/FSNS.mon.1x1.east.fldmean.a.nc FSNS.mon.1x1.east.fldmean.a.all_m.nc
  else
  cdo cat -seltimestep,${i} /home/cwengel/_proj/CESM_data_processed_pop62_lagroff/BJ_index/output_from_shscript/m${j}/FSNS.mon.1x1.east.fldmean.a.nc FSNS.mon.1x1.east.fldmean.a.all_m.nc
  fi
 done
done

for i in {1..80} ; do
 for j in ${monthlist} ; do
  if [ ${i} = 1 ] && [ ${j} = "01" ] ; then
  cdo seltimestep,${i} /home/cwengel/_proj/CESM_data_processed_pop62_lagroff/BJ_index/output_from_shscript/m${j}/FLNS.mon.1x1.east.fldmean.a.nc FLNS.mon.1x1.east.fldmean.a.all_m.nc
  else
  cdo cat -seltimestep,${i} /home/cwengel/_proj/CESM_data_processed_pop62_lagroff/BJ_index/output_from_shscript/m${j}/FLNS.mon.1x1.east.fldmean.a.nc FLNS.mon.1x1.east.fldmean.a.all_m.nc
  fi
 done
done

for i in {1..80} ; do
 for j in ${monthlist} ; do
  if [ ${i} = 1 ] && [ ${j} = "01" ] ; then
  cdo seltimestep,${i} /home/cwengel/_proj/CESM_data_processed_pop62_lagroff/BJ_index/output_from_shscript/m${j}/SHFLX.mon.1x1.east.fldmean.a.nc SHFLX.mon.1x1.east.fldmean.a.all_m.nc
  else
  cdo cat -seltimestep,${i} /home/cwengel/_proj/CESM_data_processed_pop62_lagroff/BJ_index/output_from_shscript/m${j}/SHFLX.mon.1x1.east.fldmean.a.nc SHFLX.mon.1x1.east.fldmean.a.all_m.nc
  fi
 done
done

for i in {1..80} ; do
 for j in ${monthlist} ; do
  if [ ${i} = 1 ] && [ ${j} = "01" ] ; then
  cdo seltimestep,${i} /home/cwengel/_proj/CESM_data_processed_pop62_lagroff/BJ_index/output_from_shscript/m${j}/LHFLX.mon.1x1.east.fldmean.a.nc LHFLX.mon.1x1.east.fldmean.a.all_m.nc
  else
  cdo cat -seltimestep,${i} /home/cwengel/_proj/CESM_data_processed_pop62_lagroff/BJ_index/output_from_shscript/m${j}/LHFLX.mon.1x1.east.fldmean.a.nc LHFLX.mon.1x1.east.fldmean.a.all_m.nc
  fi
 done
done

for i in {1..80} ; do
 for j in ${monthlist} ; do
  if [ ${i} = 1 ] && [ ${j} = "01" ] ; then
  cdo seltimestep,${i} /home/cwengel/_proj/CESM_data_processed_pop62_lagroff/BJ_index/output_from_shscript/m${j}/SST.mon.1x1.east.fldmean.a.nc SST.mon.1x1.east.fldmean.a.all_m.nc
  else
  cdo cat -seltimestep,${i} /home/cwengel/_proj/CESM_data_processed_pop62_lagroff/BJ_index/output_from_shscript/m${j}/SST.mon.1x1.east.fldmean.a.nc SST.mon.1x1.east.fldmean.a.all_m.nc
  fi
 done
done

for i in {1..80} ; do
 for j in ${monthlist} ; do
  if [ ${i} = 1 ] && [ ${j} = "01" ] ; then
  cdo seltimestep,${i} /home/cwengel/_proj/CESM_data_processed_pop62_lagroff/BJ_index/output_from_shscript/m${j}/TAUX.mon.1x1.eq.fldmean.a.nc TAUX.mon.1x1.eq.fldmean.a.all_m.nc
  else
  cdo cat -seltimestep,${i} /home/cwengel/_proj/CESM_data_processed_pop62_lagroff/BJ_index/output_from_shscript/m${j}/TAUX.mon.1x1.eq.fldmean.a.nc TAUX.mon.1x1.eq.fldmean.a.all_m.nc
  fi
 done
done

for i in {1..80} ; do
 for j in ${monthlist} ; do
  if [ ${i} = 1 ] && [ ${j} = "01" ] ; then
  cdo seltimestep,${i} /home/cwengel/_proj/CESM_data_processed_pop62_lagroff/BJ_index/output_from_shscript/m${j}/Hfunc_Tsuba.nc Hfunc_Tsuba.all_m.nc
  else
  cdo cat -seltimestep,${i} /home/cwengel/_proj/CESM_data_processed_pop62_lagroff/BJ_index/output_from_shscript/m${j}/Hfunc_Tsuba.nc Hfunc_Tsuba.all_m.nc
  fi
 done
done

for i in {1..80} ; do
 for j in ${monthlist} ; do
  if [ ${i} = 1 ] && [ ${j} = "01" ] ; then
  cdo seltimestep,${i} /home/cwengel/_proj/CESM_data_processed_pop62_lagroff/BJ_index/output_from_shscript/m${j}/Hfunc_upper_Wa.nc Hfunc_upper_Wa.all_m.nc
  else
  cdo cat -seltimestep,${i} /home/cwengel/_proj/CESM_data_processed_pop62_lagroff/BJ_index/output_from_shscript/m${j}/Hfunc_upper_Wa.nc Hfunc_upper_Wa.all_m.nc
  fi
 done
done

for i in {1..80} ; do
 for j in ${monthlist} ; do
  if [ ${i} = 1 ] && [ ${j} = "01" ] ; then
  cdo seltimestep,${i} /home/cwengel/_proj/CESM_data_processed_pop62_lagroff/BJ_index/output_from_shscript/m${j}/Hfunc_upper_W.nc Hfunc_upper_W.all_m.nc
  else
  cdo cat -seltimestep,${i} /home/cwengel/_proj/CESM_data_processed_pop62_lagroff/BJ_index/output_from_shscript/m${j}/Hfunc_upper_W.nc Hfunc_upper_W.all_m.nc
  fi
 done
done

for i in {1..80} ; do
 for j in ${monthlist} ; do
  if [ ${i} = 1 ] && [ ${j} = "01" ] ; then
  cdo seltimestep,${i} /home/cwengel/_proj/CESM_data_processed_pop62_lagroff/BJ_index/output_from_shscript/m${j}/Upper_fldmeanUa.nc Upper_fldmeanUa.all_m.nc
  else
  cdo cat -seltimestep,${i} /home/cwengel/_proj/CESM_data_processed_pop62_lagroff/BJ_index/output_from_shscript/m${j}/Upper_fldmeanUa.nc Upper_fldmeanUa.all_m.nc
  fi
 done
done

#for i in {1..80} ; do
# for j in ${monthlist} ; do
#  if [ ${i} = 1 ] && [ ${j} = "01" ] ; then
#  cdo seltimestep,${i} /home/cwengel/_proj/CESM_data_processed_pop62_lagroff/BJ_index/output_from_shscript/m${j}/Z20a_grad_E-W_fldmean.nc Z20a_grad_E-W_fldmean.all_m.nc
#  else
#  cdo cat -seltimestep,${i} /home/cwengel/_proj/CESM_data_processed_pop62_lagroff/BJ_index/output_from_shscript/m${j}/Z20a_grad_E-W_fldmean.nc Z20a_grad_E-W_fldmean.all_m.nc
#  fi
# done
#done
#cdo settaxis,0001-01-15,12:00,1month Z20a_grad_E-W_fldmean.all_m.nc Z20a_grad_E-W_fldmean.all_m.taxis.nc
#mv Z20a_grad_E-W_fldmean.all_m.taxis.nc Z20a_grad_E-W_fldmean.all_m.nc
#
#for i in {1..80} ; do
# for j in ${monthlist} ; do
#  if [ ${i} = 1 ] && [ ${j} = "01" ] ; then
#  cdo seltimestep,${i} /home/cwengel/_proj/CESM_data_processed_pop62_lagroff/BJ_index/output_from_shscript/m${j}/Z20a_E_fldmean.nc Z20a_E_fldmean.all_m.nc
#  else
#  cdo cat -seltimestep,${i} /home/cwengel/_proj/CESM_data_processed_pop62_lagroff/BJ_index/output_from_shscript/m${j}/Z20a_E_fldmean.nc Z20a_E_fldmean.all_m.nc
#  fi
# done
#done
#cdo settaxis,0001-01-15,12:00,1month Z20a_E_fldmean.all_m.nc Z20a_E_fldmean.all_m.taxis.nc
#mv Z20a_E_fldmean.all_m.taxis.nc Z20a_E_fldmean.all_m.nc
#
#for i in {1..80} ; do
# for j in ${monthlist} ; do
#  if [ ${i} = 1 ] && [ ${j} = "01" ] ; then
#  cdo seltimestep,${i} /home/cwengel/_proj/CESM_data_processed_pop62_lagroff/BJ_index/output_from_shscript/m${j}/Z20a_W_fldmean.nc Z20a_W_fldmean.all_m.nc
#  else
#  cdo cat -seltimestep,${i} /home/cwengel/_proj/CESM_data_processed_pop62_lagroff/BJ_index/output_from_shscript/m${j}/Z20a_W_fldmean.nc Z20a_W_fldmean.all_m.nc
#  fi
# done
#done
#cdo settaxis,0001-01-15,12:00,1month Z20a_W_fldmean.all_m.nc Z20a_W_fldmean.all_m.taxis.nc
#mv Z20a_W_fldmean.all_m.taxis.nc Z20a_W_fldmean.all_m.nc

#thermocline
for i in {1..80} ; do
 for j in ${monthlist} ; do
  if [ ${i} = 1 ] && [ ${j} = "01" ] ; then
  cdo seltimestep,${i} /home/cwengel/_proj/CESM_data_processed_pop62_lagroff/BJ_index/output_from_shscript/m${j}/thermoclinea_grad_E-W_fldmean.nc thermoclinea_grad_E-W_fldmean.all_m.nc
  else
  cdo cat -seltimestep,${i} /home/cwengel/_proj/CESM_data_processed_pop62_lagroff/BJ_index/output_from_shscript/m${j}/thermoclinea_grad_E-W_fldmean.nc thermoclinea_grad_E-W_fldmean.all_m.nc
  fi
 done
done
cdo settaxis,0001-01-15,12:00,1month thermoclinea_grad_E-W_fldmean.all_m.nc thermoclinea_grad_E-W_fldmean.all_m.taxis.nc
mv thermoclinea_grad_E-W_fldmean.all_m.taxis.nc thermoclinea_grad_E-W_fldmean.all_m.nc

for i in {1..80} ; do
 for j in ${monthlist} ; do
  if [ ${i} = 1 ] && [ ${j} = "01" ] ; then
  cdo seltimestep,${i} /home/cwengel/_proj/CESM_data_processed_pop62_lagroff/BJ_index/output_from_shscript/m${j}/thermoclinea_E_fldmean.nc thermoclinea_E_fldmean.all_m.nc
  else
  cdo cat -seltimestep,${i} /home/cwengel/_proj/CESM_data_processed_pop62_lagroff/BJ_index/output_from_shscript/m${j}/thermoclinea_E_fldmean.nc thermoclinea_E_fldmean.all_m.nc
  fi
 done
done
cdo settaxis,0001-01-15,12:00,1month thermoclinea_E_fldmean.all_m.nc thermoclinea_E_fldmean.all_m.taxis.nc
mv thermoclinea_E_fldmean.all_m.taxis.nc thermoclinea_E_fldmean.all_m.nc

for i in {1..80} ; do
 for j in ${monthlist} ; do
  if [ ${i} = 1 ] && [ ${j} = "01" ] ; then
  cdo seltimestep,${i} /home/cwengel/_proj/CESM_data_processed_pop62_lagroff/BJ_index/output_from_shscript/m${j}/thermoclinea_W_fldmean.nc thermoclinea_W_fldmean.all_m.nc
  else
  cdo cat -seltimestep,${i} /home/cwengel/_proj/CESM_data_processed_pop62_lagroff/BJ_index/output_from_shscript/m${j}/thermoclinea_W_fldmean.nc thermoclinea_W_fldmean.all_m.nc
  fi
 done
done
cdo settaxis,0001-01-15,12:00,1month thermoclinea_W_fldmean.all_m.nc thermoclinea_W_fldmean.all_m.taxis.nc
mv thermoclinea_W_fldmean.all_m.taxis.nc thermoclinea_W_fldmean.all_m.nc

cdo -r runmean,3 QNET.mon.1x1.east.fldmean.a.all_m.nc QNET.mon.1x1.east.fldmean.a.all_m.runmean.nc
cdo -r runmean,3 FSNS.mon.1x1.east.fldmean.a.all_m.nc FSNS.mon.1x1.east.fldmean.a.all_m.runmean.nc
cdo -r runmean,3 FLNS.mon.1x1.east.fldmean.a.all_m.nc FLNS.mon.1x1.east.fldmean.a.all_m.runmean.nc
cdo -r runmean,3 LHFLX.mon.1x1.east.fldmean.a.all_m.nc LHFLX.mon.1x1.east.fldmean.a.all_m.runmean.nc
cdo -r runmean,3 SHFLX.mon.1x1.east.fldmean.a.all_m.nc SHFLX.mon.1x1.east.fldmean.a.all_m.runmean.nc
cdo -r runmean,3 SST.mon.1x1.east.fldmean.a.all_m.nc SST.mon.1x1.east.fldmean.a.all_m.runmean.nc
cdo -r runmean,3 TAUX.mon.1x1.eq.fldmean.a.all_m.nc TAUX.mon.1x1.eq.fldmean.a.all_m.runmean.nc
cdo -r runmean,3 Hfunc_Tsuba.all_m.nc Hfunc_Tsuba.all_m.runmean.nc
cdo -r runmean,3 Hfunc_upper_Wa.all_m.nc Hfunc_upper_Wa.all_m.runmean.nc
cdo -r runmean,3 Hfunc_upper_W.all_m.nc Hfunc_upper_W.all_m.runmean.nc
cdo -r runmean,3 Upper_fldmeanUa.all_m.nc Upper_fldmeanUa.all_m.runmean.nc
#cdo -r runmean,3 Z20a_grad_E-W_fldmean.all_m.nc Z20a_grad_E-W_fldmean.all_m.rummean.nc
#cdo -r runmean,3 Z20a_E_fldmean.all_m.nc Z20a_E_fldmean.all_m.runmean.nc
#cdo -r runmean,3 Z20a_W_fldmean.all_m.nc Z20a_W_fldmean.all_m.runmean.nc
cdo -r runmean,3 thermoclinea_grad_E-W_fldmean.all_m.nc thermoclinea_grad_E-W_fldmean.all_m.rummean.nc
cdo -r runmean,3 thermoclinea_E_fldmean.all_m.nc thermoclinea_E_fldmean.all_m.runmean.nc
cdo -r runmean,3 thermoclinea_W_fldmean.all_m.nc thermoclinea_W_fldmean.all_m.runmean.nc


for mm in ${monthlist}; do
 cdo -r selmon,${mm} QNET.mon.1x1.east.fldmean.a.all_m.runmean.nc /home/cwengel/_proj/CESM_data_processed_pop62_lagroff/BJ_index/output_from_shscript/m${mm}/QNET.mon.1x1.east.fldmean.a.rm.nc
 cdo -r selmon,${mm} FSNS.mon.1x1.east.fldmean.a.all_m.runmean.nc /home/cwengel/_proj/CESM_data_processed_pop62_lagroff/BJ_index/output_from_shscript/m${mm}/FSNS.mon.1x1.east.fldmean.a.rm.nc
 cdo -r selmon,${mm} FLNS.mon.1x1.east.fldmean.a.all_m.runmean.nc /home/cwengel/_proj/CESM_data_processed_pop62_lagroff/BJ_index/output_from_shscript/m${mm}/FLNS.mon.1x1.east.fldmean.a.rm.nc
 cdo -r selmon,${mm} LHFLX.mon.1x1.east.fldmean.a.all_m.runmean.nc /home/cwengel/_proj/CESM_data_processed_pop62_lagroff/BJ_index/output_from_shscript/m${mm}/LHFLX.mon.1x1.east.fldmean.a.rm.nc
 cdo -r selmon,${mm} SHFLX.mon.1x1.east.fldmean.a.all_m.runmean.nc /home/cwengel/_proj/CESM_data_processed_pop62_lagroff/BJ_index/output_from_shscript/m${mm}/SHFLX.mon.1x1.east.fldmean.a.rm.nc
 cdo -r selmon,${mm} SST.mon.1x1.east.fldmean.a.all_m.runmean.nc /home/cwengel/_proj/CESM_data_processed_pop62_lagroff/BJ_index/output_from_shscript/m${mm}/SST.mon.1x1.east.fldmean.a.rm.nc
 cdo -r selmon,${mm} TAUX.mon.1x1.eq.fldmean.a.all_m.runmean.nc /home/cwengel/_proj/CESM_data_processed_pop62_lagroff/BJ_index/output_from_shscript/m${mm}/TAUX.mon.1x1.eq.fldmean.a.rm.nc
 cdo -r selmon,${mm} Hfunc_Tsuba.all_m.runmean.nc /home/cwengel/_proj/CESM_data_processed_pop62_lagroff/BJ_index/output_from_shscript/m${mm}/Hfunc_Tsuba.rm.nc
 cdo -r selmon,${mm} Hfunc_upper_Wa.all_m.runmean.nc /home/cwengel/_proj/CESM_data_processed_pop62_lagroff/BJ_index/output_from_shscript/m${mm}/Hfunc_upper_Wa.rm.nc
 cdo -r selmon,${mm} Hfunc_upper_W.all_m.runmean.nc /home/cwengel/_proj/CESM_data_processed_pop62_lagroff/BJ_index/output_from_shscript/m${mm}/Hfunc_upper_W.rm.nc
 cdo -r selmon,${mm} Upper_fldmeanUa.all_m.runmean.nc /home/cwengel/_proj/CESM_data_processed_pop62_lagroff/BJ_index/output_from_shscript/m${mm}/Upper_fldmeanUa.rm.nc
 #cdo -r selmon,${mm} Z20a_grad_E-W_fldmean.all_m.rummean.nc /home/cwengel/_proj/CESM_data_processed_pop62_lagroff/BJ_index/output_from_shscript/m${mm}/Z20a_grad_E-W_fldmean.rm.nc
 #cdo -r selmon,${mm} Z20a_E_fldmean.all_m.runmean.nc /home/cwengel/_proj/CESM_data_processed_pop62_lagroff/BJ_index/output_from_shscript/m${mm}/Z20a_E_fldmean.rm.nc
 #cdo -r selmon,${mm} Z20a_W_fldmean.all_m.runmean.nc /home/cwengel/_proj/CESM_data_processed_pop62_lagroff/BJ_index/output_from_shscript/m${mm}/Z20a_W_fldmean.rm.nc
 cdo -r selmon,${mm} thermoclinea_grad_E-W_fldmean.all_m.rummean.nc /home/cwengel/_proj/CESM_data_processed_pop62_lagroff/BJ_index/output_from_shscript/m${mm}/thermoclinea_grad_E-W_fldmean.rm.nc
 cdo -r selmon,${mm} thermoclinea_E_fldmean.all_m.runmean.nc /home/cwengel/_proj/CESM_data_processed_pop62_lagroff/BJ_index/output_from_shscript/m${mm}/thermoclinea_E_fldmean.rm.nc
 cdo -r selmon,${mm} thermoclinea_W_fldmean.all_m.runmean.nc /home/cwengel/_proj/CESM_data_processed_pop62_lagroff/BJ_index/output_from_shscript/m${mm}/thermoclinea_W_fldmean.rm.nc
done #mm
