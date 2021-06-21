%%%%%%%%%%%%%BJ stability Index
clear;clc;close all;

MLT_file = ['HMXL.mon.0061-0140.1x1.east.ymonmean.nc'];
mxld = ncread(MLT_file,'HMXL');

for mm=1:12
if mm<10
path1_pre = '/mnt/lustre01/work/mh0731/m300845/ENSO/submission2/BJ/BJ_aleph/PD/output_from_shscript/m0';
else
path1_pre = '/mnt/lustre01/work/mh0731/m300845/ENSO/submission2/BJ/BJ_aleph/PD/output_from_shscript/m';
end
path_add = '/';
path = [path1_pre,num2str(mm),path_add];
cd(path);

% Variable DD TD ZAF EF TF BJ are Dynamical Damping, Thermal Damping, Zonal
% Advection Feedback, Ekaman Feedback,Thermocline Feedback and total BJ
% Index

%mxld_month = 5500;
%mxld_m = mxld_month*1e-2;

mxld_month = mxld(mm);
mxld_m = mxld_month*1e-2;
mxld_m;

%%all grid 
% field mean sst anomalies
SSTa_file = [path,'SST.mon.1x1.east.fldmean.a.rm.nc'];
%%all grid 
% field mean downward heatflux anomalies
HFLUXa_file = [path,'QNET.mon.1x1.east.fldmean.a.rm.nc'];

%%%%%%%%%%trflwac -- heatflx variable name in ncfile
ssta_E = ncread(SSTa_file,'SST');
hfluxa_E = ncread(HFLUXa_file,'SRFRAD');
ssta_E = squeeze(ssta_E);
[A B C] = size(ssta_E);
ssta_E = reshape(ssta_E,1,A*B*C);
hfluxa_E= reshape(hfluxa_E,1,A*B*C);
[P_TD,P_TD_CI] = regress(hfluxa_E',ssta_E',0.1);
P_TD_all(mm) = P_TD;
%% DONE SAVING

TD = P_TD/(mxld_m*3989.24*1035)*365*43200;
TD_CI = abs(P_TD-P_TD_CI)/(mxld_m*3989.24*1035)*365*43200;

%heatfl decomp
swa_file = [path,'FSNS.mon.1x1.east.fldmean.a.rm.nc'];
sw_E = ncread(swa_file,'FSNS');
sw_E= reshape(sw_E,1,A*B*C);
[P_TD_sw,P_TD_sw_CI] = regress(sw_E',ssta_E',0.1);
TD_sw = P_TD_sw/(mxld_m*3989.24*1035)*365*43200;
TD_sw_CI = abs(P_TD_sw-P_TD_sw_CI)/(mxld_m*3989.24*1035)*365*43200;
sw_all(mm) = TD_sw;
TD_sw = P_TD_sw/(mxld_m*3989.24*1035)*365*43200;
TD_sw_CI = P_TD_sw_CI./(mxld_m*3989.24*1035)*365*43200;
sw_CI_all(mm)  = abs(TD_sw-TD_sw_CI(1));

lwa_file = [path,'FLNS.mon.1x1.east.fldmean.a.rm.nc'];
lw_E = ncread(lwa_file,'FLNS');
lw_E= reshape(lw_E,1,A*B*C);
[P_TD_lw,P_TD_lw_CI] = regress(lw_E',ssta_E',0.1);
TD_lw = P_TD_lw/(mxld_m*3989.24*1035)*365*43200;
TD_lw_CI = abs(P_TD_lw-P_TD_lw_CI)/(mxld_m*3989.24*1035)*365*43200;
lw_all(mm) = TD_lw;
%lw_CI_all(mm) = TD_lw_CI;

lha_file = [path,'LHFLX.mon.1x1.east.fldmean.a.rm.nc'];
lh_E = ncread(lha_file,'LHFLX');
lh_E= reshape(lh_E,1,A*B*C);
[P_TD_lh,P_TD_lh_CI] = regress(lh_E',ssta_E',0.1);
TD_lh = P_TD_lh/(mxld_m*3989.24*1035)*365*43200;
%TD_lh_CI = abs(P_TD_lh-P_TD_lh_CI)/(mxld_m*3989.24*1035)*365*43200;
TD_lh_CI = P_TD_lh_CI./(mxld_m*3989.24*1035)*365*43200;

lh_all(mm) = TD_lh;
lh_CI_all(mm)  = abs(TD_lh-TD_lh_CI(1));


sha_file = [path,'SHFLX.mon.1x1.east.fldmean.a.rm.nc'];
sh_E = ncread(sha_file,'SHFLX');
sh_E= reshape(sh_E,1,A*B*C);
[P_TD_sh,P_TD_sh_CI] = regress(sh_E',ssta_E',0.1);
TD_sh = P_TD_sh/(mxld_m*3989.24*1035)*365*43200;
TD_sh_CI = abs(P_TD_sh-P_TD_sh_CI)/(mxld_m*3989.24*1035)*365*43200;
sh_all(mm) = TD_sh;
%sh_CI_all(mm) = TD_sh_CI;

%%%%%%%%relation between Tropical Pacific windstress anomoly and SST anomaly
%%%%in East Equatorial Pacific
file_name1 = [path,'SST.mon.1x1.east.fldmean.a.rm.nc'];
file_name4 = [path,'TAUX.mon.1x1.eq.fldmean.a.rm.nc'];
%%%%%%%%%%trflwac -- heatflx
ssta_E = ncread(file_name1,'SST');
ustr_P = ncread(file_name4,'TAUX');
ssta_E = squeeze(ssta_E);
ustr_P = squeeze(ustr_P);
[miua,miua_CI] = regress(ustr_P,ssta_E,0.1);
miua_CI_all(mm)  = abs(miua-miua_CI(1));
%%%%%%%%%%%%%Dynamical Damping
file_name_DD_U = [path,'DD_Term1.nc'];
file_name_DD_V = [path,'DD_Term2.nc'];
file_name_DD_W = [path,'Upper_fldmeanW.nc'];

u = ncread(file_name_DD_U,'UVEL');
v = ncread(file_name_DD_V,'VVEL');
w = ncread(file_name_DD_W,'WVEL');

% BJ_Index 1
DD_zonal = (-1)*mean(u/100)*43200*365;% 100==>longitudinal extent
DD_zonal_std = std(u/100)*43200*365;
DD_mer = (-1)*mean(v*11132000)*43200*365;
DD_mer_std = std(v*11132000)*43200*365;
DD_ver = (-1)*(mean(w))/mxld_month*43200*365;% divided by mxl already
DD_ver_std = (std(w))/mxld_month*43200*365;% divided by mxl already
DD = DD_zonal + DD_mer + DD_ver;

DD_total_std = sqrt(DD_zonal_std^2 + DD_mer_std^2 + DD_ver_std^2);

DD_CI(1) = DD_total_std;
DD_CI(2) = DD_total_std;

mean_u_all(mm) = mean(u);
DD_zonal_all(mm) = DD_zonal;
DD_mer_all(mm) = DD_mer;
mean_w_all(mm) = mean(w);
mxld_month_all(mm) = mxld_month;
DD_ver_all(mm) = DD_ver;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Upper_Vol_Ua_file = ['Upper_fldmeanUa.rm.nc'];
Upper_Vol_Ua = ncread(Upper_Vol_Ua_file,'UVEL');

%Z20a_W_file = ['Z20a_W_fldmean.rm.nc'];
%Z20a_W = ncread(Z20a_W_file,'Z20');

%file_name4 = [path,'TAUX.mon.1x1.eq.fldmean.a.rm.nc'];
%ustrwa = ncread(file_name4,'TAUX');
%ustrwa = squeeze(ustrwa);
%Upper_Vol_Ua = squeeze(Upper_Vol_Ua);
%Z20a_W = squeeze(Z20a_W);

thermoclinea_W_file = ['thermoclinea_W_fldmean.rm.nc'];
thermoclinea_W = ncread(thermoclinea_W_file,'THERMOCLINE');

file_name4 = [path,'TAUX.mon.1x1.eq.fldmean.a.rm.nc'];
ustrwa = ncread(file_name4,'TAUX');
ustrwa = squeeze(ustrwa);
Upper_Vol_Ua = squeeze(Upper_Vol_Ua);
thermoclinea_W = squeeze(thermoclinea_W);


%%%%multi-linear regression b = regress(y,[ones(size(y)),x1,x2])
%%%%[b,bint,r,rint,stats] = regress(y,[ones(size(y)),x1,x2]) regression
%%%%significant test
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %[s,sint,r,rint,stats] = regress(Upper_Vol_Ua,[ones(size(Upper_Vol_Ua)),ustrwa,Z20a_W],0.1);
 [s,sint,r,rint,stats] = regress(Upper_Vol_Ua,[ones(size(Upper_Vol_Ua)),ustrwa,thermoclinea_W],0.1);

beita_u = s(2);
beita_u_CI = sint(2,:);
beita_u_CI_all(mm)  = abs(beita_u-beita_u_CI(1));

beita_uh =s(3);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%ZAF(Zonal Advection Feedback)
%%%%%%%%%%%%%%% fieldmean zonal climtological SST gradient
file_name_TG = [path,'Zonal_SST_grad_E.nc'];
SST_Grad = ncread(file_name_TG,'SST');
SST_Grad = (-1)*squeeze(SST_Grad);
zosst_grad = mean(SST_Grad);
zosst_grad_all(mm) = zosst_grad;
ZAF = miua.*zosst_grad.*beita_u*43200*365;
ZAF_CI = (beita_u.*(abs(miua-miua_CI))+miua.*(abs(beita_u-beita_u_CI))+(abs(miua-miua_CI).*abs(beita_u-beita_u_CI))).*zosst_grad*43200*365;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%EF (Ekman Feedback)
%%%%%%%%%%%%field 
Vert_Temp_Grad_file = [path,'Vertical_SST_grad_E.mean.nc'];
Vert_Temp= ncread(Vert_Temp_Grad_file,'TEMP_GRAD');
Vert_Temp_Grad = squeeze(mean(Vert_Temp))*1e-2;
Vert_Temp_Grad_all(mm) = Vert_Temp_Grad;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%beita_w
Wa_HFuc_file = [path,'Hfunc_upper_Wa.rm.nc'];
Wa_HFuc_E = ncread(Wa_HFuc_file,'WVEL');
Wa_HFuc_E = squeeze(Wa_HFuc_E)-squeeze(mean(Wa_HFuc_E));
ustrwa_file = [path,'TAUX.mon.1x1.eq.fldmean.a.rm.nc'];
ustrwa = ncread(ustrwa_file,'TAUX');
ustrwa = squeeze(ustrwa);

[beita_w,beita_w_CI] = regress(Wa_HFuc_E,ustrwa,0.1);

beita_w = beita_w*(-1);
beita_w_all(mm) = beita_w;
beita_w_CI = fliplr(beita_w_CI*(-1));
beita_w_CI_all(mm)  = abs(beita_w-beita_w_CI(1));

EF=miua*beita_w*Vert_Temp_Grad*43200*365*(-1);
EF_CI=(beita_w.*(abs(miua-miua_CI))+miua.*(abs(beita_w-beita_w_CI))+(abs(miua-miua_CI).*abs(beita_w-beita_w_CI))).*Vert_Temp_Grad.*43200.*365*(-1);
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%TF (Thermocline Feedbak)
%Z20a_Grad_file = [path,'Z20a_grad_E-W_fldmean.rm.nc'];
%Z20a_Grad = ncread(Z20a_Grad_file,'Z20');
%ustrwa_file = [path,'TAUX.mon.1x1.eq.fldmean.a.rm.nc'];
%ustrwa = ncread(ustrwa_file,'TAUX');
%ustrwa = squeeze(ustrwa);
%Z20a_Grad = squeeze(Z20a_Grad);

thermoclinea_Grad_file = [path,'thermoclinea_grad_E-W_fldmean.rm.nc'];
thermoclinea_Grad = ncread(thermoclinea_Grad_file,'THERMOCLINE');
ustrwa_file = [path,'TAUX.mon.1x1.eq.fldmean.a.rm.nc'];
ustrwa = ncread(ustrwa_file,'TAUX');
ustrwa = squeeze(ustrwa);
thermoclinea_Grad = squeeze(thermoclinea_Grad);

thermocline_Grad_file = [path,'thermocline_grad_E-W_fldmean.nc'];
thermocline_Grad = ncread(thermocline_Grad_file,'THERMOCLINE');
thermocline_Grad_mean_all(mm) = squeeze(mean(thermocline_Grad))*-1;

%BJ_Index1

%[beita_h,beita_h_CI] = regress(Z20a_Grad,ustrwa,0.1);
[beita_h,beita_h_CI] = regress(thermoclinea_Grad,ustrwa,0.1);
beita_h_CI_all(mm)  = abs(beita_h-beita_h_CI(1));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% a_h
%Tsub_A_file = [path,'Hfunc_Tsuba.rm.nc'];
%Tsub_A = ncread(Tsub_A_file,'temp');
%thermoclinea_E_file = [path,'thermoclinea_E_fldmean.rm.nc'];
%thermoclinea_E = ncread(thermoclinea_E_file,'thermocline');
%thermoclinea_E = squeeze(thermoclinea_E);
%Tsub_A = squeeze(Tsub_A);
%
%[a_h,a_h_CI] = regress(Tsub_A,thermoclinea_E,0.1);

Tsub_A_file = [path,'Hfunc_Tsuba.n3.rm.nc'];
Tsub_A = ncread(Tsub_A_file,'temp');
thermoclinea_E_file = [path,'thermoclinea_E_fldmean_n3.rm.nc'];
thermoclinea_E = ncread(thermoclinea_E_file,'THERMOCLINE');
thermoclinea_E = squeeze(thermoclinea_E);
Tsub_A = squeeze(Tsub_A);

% OLD AH
[a_h,a_h_CI] = regress(Tsub_A,thermoclinea_E,0.1);
a_h_CI_all(mm) = abs(a_h-a_h_CI(1));

 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 Hfunc_W = ncread([path,'Hfunc_upper_W.rm.nc'],'WVEL');
 Hfunc_W = squeeze(mean(Hfunc_W));

 TF = miua*beita_h*a_h*Hfunc_W*365*43200/mxld_month;
 miua_all(mm) = miua;
 beita_h_all(mm) = beita_h;
 a_h_all(mm) = a_h;
 Hfunc_W_all(mm) = Hfunc_W; 
 w_mld_all(mm) = Hfunc_W/(mxld_month/1e2);
 TF_all(mm) = TF; 
 beita_u_all(mm) = beita_u;


 delta_miua = abs(miua-miua_CI);
 delta_beita_h = abs(beita_h-beita_h_CI);
 delta_a_h = abs(a_h-a_h_CI);

 TF_CI = (miua.*beita_h.*delta_a_h+miua.*delta_beita_h.*delta_a_h+miua.*delta_beita_h.*delta_a_h+beita_h.*delta_miua.*a_h+beita_h.*delta_miua.*delta_a_h.*delta_miua.*delta_beita_h.*a_h+delta_miua.*delta_beita_h.*delta_a_h).*Hfunc_W*365*43200/mxld_month;

%TIW
mm_str = num2str(mm);

HFCa_file = [strcat('/mnt/lustre01/work/mh0731/m300845/ENSO/submission2/BJ/BJ_aleph/PD/HFC.VEL_TIW.T_TIW.monmean.a.rm.',mm_str,'.nc')];
HFCa = ncread(HFCa_file,'HFC_VEL_TIW_T_TIW');

[P_TIW,P_TIW_CI] = regress(HFCa,squeeze(ssta_E),0.1);
TIW = P_TIW*12;
TIW_CI = abs(P_TIW-P_TIW_CI)*12;

%BJ INDEX
F = (beita_uh*zosst_grad + a_h*Hfunc_W/mxld_month)*365*43200;

BJ = DD+TD+ZAF+EF+TF+TIW;
%BJ_ind = [DD; TD; ZAF; TF; EF; BJ]; 
BJ_ind(mm,:) = [TIW; DD; TD; ZAF; TF; EF; BJ];

BJ_CI = sqrt(DD_CI.^2+TD_CI.^2+ZAF_CI.^2+EF_CI.^2+TF_CI.^2+TIW_CI.^2);
BJ_ind_CI(mm,:) = [TIW_CI(1); DD_CI(1); TD_CI(1); ZAF_CI(1); TF_CI(1); EF_CI(1); BJ_CI(1)];

%
end

%save
path_out = '/mnt/lustre01/work/mh0731/m300845/ENSO/submission2/BJ/BJ_aleph/PD/output_from_shscript';
cd(path_out)

ncid = netcdf.create('BJ_ind_mon.nc','clobber');
dimidn = netcdf.defDim(ncid,'elements',7);
dimidt = netcdf.defDim(ncid,'months',12);
BJ_ID = netcdf.defVar(ncid,'BJFB','double',[dimidt dimidn]);
BJ_CI_ID = netcdf.defVar(ncid,'BJFB_CI','double',[dimidt dimidn]);
miua_ID = netcdf.defVar(ncid,'miua','double',[dimidt]);
miua_CI_ID = netcdf.defVar(ncid,'miua_CI','double',[dimidt]);
beita_h_ID = netcdf.defVar(ncid,'beita_h','double',[dimidt]);
beita_h_CI_ID = netcdf.defVar(ncid,'beita_h_CI','double',[dimidt]);
a_h_ID = netcdf.defVar(ncid,'a_h','double',[dimidt]);
a_h_CI_ID = netcdf.defVar(ncid,'a_h_CI','double',[dimidt]);
Hfunc_W_ID = netcdf.defVar(ncid,'Hfunc_W','double',[dimidt]);
beita_u_ID = netcdf.defVar(ncid,'beita_u','double',[dimidt]);
beita_u_CI_ID = netcdf.defVar(ncid,'beita_u_CI','double',[dimidt]);
zosst_grad_ID = netcdf.defVar(ncid,'zosst_grad','double',[dimidt]);
beita_w_ID = netcdf.defVar(ncid,'beita_w','double',[dimidt]);
beita_w_CI_ID = netcdf.defVar(ncid,'beita_w_CI','double',[dimidt]);
vert_temp_grad_ID = netcdf.defVar(ncid,'vert_temp_grad','double',[dimidt]);
thermocline_Grad_mean_all_ID = netcdf.defVar(ncid,'mean_thermocline_slope','double',[dimidt]);
sw_ID = netcdf.defVar(ncid,'sw','double',[dimidt]);
sw_CI_ID = netcdf.defVar(ncid,'sw_CI','double',[dimidt]);
lw_ID = netcdf.defVar(ncid,'lw','double',[dimidt]);
lh_ID = netcdf.defVar(ncid,'lh','double',[dimidt]);
lh_CI_ID = netcdf.defVar(ncid,'lh_CI','double',[dimidt]);
sh_ID = netcdf.defVar(ncid,'sh','double',[dimidt]);
DD_zonal_ID = netcdf.defVar(ncid,'DD_zonal','double',[dimidt]);
DD_ver_ID = netcdf.defVar(ncid,'DD_ver','double',[dimidt]);
netcdf.endDef(ncid);
netcdf.putVar(ncid,BJ_ID,BJ_ind);
netcdf.putVar(ncid,BJ_CI_ID,BJ_ind_CI);
netcdf.putVar(ncid,miua_ID,miua_all);
netcdf.putVar(ncid,miua_CI_ID,miua_CI_all);
netcdf.putVar(ncid,beita_h_ID,beita_h_all);
netcdf.putVar(ncid,beita_h_CI_ID,beita_h_CI_all);
netcdf.putVar(ncid,a_h_ID,a_h_all);
netcdf.putVar(ncid,a_h_CI_ID,a_h_CI_all);
netcdf.putVar(ncid,Hfunc_W_ID,w_mld_all);
netcdf.putVar(ncid,beita_u_ID,beita_u_all);
netcdf.putVar(ncid,beita_u_CI_ID,beita_u_CI_all);
netcdf.putVar(ncid,zosst_grad_ID,zosst_grad_all);
netcdf.putVar(ncid,beita_w_ID,beita_w_all);
netcdf.putVar(ncid,beita_w_CI_ID,beita_w_CI_all);
netcdf.putVar(ncid,vert_temp_grad_ID,Vert_Temp_Grad_all);
netcdf.putVar(ncid,thermocline_Grad_mean_all_ID,thermocline_Grad_mean_all);
netcdf.putVar(ncid,sw_ID,sw_all);
netcdf.putVar(ncid,sw_CI_ID,sw_CI_all);
netcdf.putVar(ncid,lw_ID,lw_all);
netcdf.putVar(ncid,lh_ID,lh_all);
netcdf.putVar(ncid,lh_CI_ID,lh_CI_all);
netcdf.putVar(ncid,sh_ID,sh_all);
netcdf.putVar(ncid,DD_zonal_ID,DD_zonal_all);
netcdf.putVar(ncid,DD_ver_ID,DD_ver_all);
netcdf.close(ncid);

cd ../
