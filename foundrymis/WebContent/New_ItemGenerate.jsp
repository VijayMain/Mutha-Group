<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>  
	<table width="100%" style="table-layout:fixed;">
		<tr>
			<td width="05%" colspan="05" align="left"> &nbsp</td>
			<td Width="25%" colspan="25" align="left">
				<label class="caption">Item Name*</label>
			</td>
			<td Width="70%" colspan="70" align="left">
				<Input Type="Text" Id="txtName" name="txtName" TabIndex="2"  Size="70" MaxLength="100" >
			</td>
		</tr>
		<tr>
			<td width="05%" colspan="05" align="left"> &nbsp</td>
			<td Width="25%" colspan="25" align="left">
				<label class="caption">Inv Name</label>
			</td>
			<td Width="70%" colspan="70" align="left">
				<Input Type="Text" Id="txtInvName" name="txtInvName" TabIndex="3"  Size="70" MaxLength="100" >
			</td>
		</tr>
		<tr>
			<td width="05%" colspan="05" align="left"> &nbsp</td>
			<td Width="25%" colspan="25" align="left">
				<label class="caption">Sub Grade*</label>
			</td>
			<td Width="20%" colspan="20" align="left">
				<Select id="drpSubGrade" name="drpSubGrade" TabIndex="4"  onblur="assignGrade()" > 
					<Option Value="104|104" >ALLUMINIUM</Option> 
					<Option Value="101|102" >Cast Iron</Option> 
					<Option Value="103|101" >S G IRON </Option> 
				</select>
			</td>
			<td Width="15%" colspan="15" align="left">
				<label class="caption" >UOM</label>
			</td>
			<td Width="35%" colspan="35" align="left">
				<Select id="drpUnitCode" name="drpUnitCode"  TabIndex="5"  disabled >
				
				<Option Value="NOS  " >NUMBERS</Option>
				
				</select>
			</td>
		</tr>
		<tr>
			<td width="05%" colspan="05" align="left"> &nbsp</td>
			<td Width="25%" colspan="25" align="left">
				<label class="caption" >Sub Grade Description</label>
			</td>
			<td Width="70%" colspan="70" align="left">
				<Input Type="Text" Id="txtSubGradeDesc" name="txtSubGradeDesc" TabIndex="6"  Size="30" MaxLength="50" >
			</td>
		</tr>
		<tr>
			<td width="05%" colspan="05" align="left"> &nbsp</td>
			<td Width="25%" colspan="25" align="left">
				<label class="caption" >Item Type</label>
			</td>
			<td Width="70%" colspan="70" align="left">
				<Select id="drpItemType" name="drpItemType" TabIndex="7" >
					<Option Value="0"> Purchase or Own Production </Option>
					<Option Value="1"> Job Work Machining </Option>
					<Option Value="2"> Own Production </Option>

						<Option Value="3"> Job Work or Own Production </Option>

				</select>
			</td>
		</tr>
		
			<Input Type="hidden" Id="txtCustPartCode" name="txtCustPartCode" value="">

		<tr>
			<td width="05%" colspan="05" align="left"> &nbsp</td>
			<td Width="25%" colspan="25" align="left">
				<label class="caption" >Drawing Number</label>
			</td>
			<td Width="20%" colspan="20" align="left">
				<Input Type="Text" Id="txtRefPartCode" name="txtRefPartCode" TabIndex="8"  Size="22" MaxLength="20" >
			</td>
			<td Width="15%" colspan="15" align="left">
				<Label class="Caption">Revision Number</Label>
			</td>
			<td Width="10%" colspan="10" align="left">
				<Input Type="Text" Id="txtRevNo" name="txtRevNo" TabIndex="9"  Size="12" MaxLength="10" >
			</td>
			<td Width="10%" colspan="10" align="left">
				<Label class="Caption">Rev. Date</Label>
			</td>
			<td Width="15%" colspan="15" align="left">
				<Input Type="Text" Name="txtRevDate" Id="txtRevDate" Size="10" MaxLength="10" Tabindex="10"  OnBlur="chkValidFormatDate(this,'dd/mm/yyyy')" >
				<a href="javascript:showCal('Calendar1')">
				<img src="../../images/cal.gif" width="16" height="16" Border="1" TabIndex="11" ></a>
			</td>
		</tr>
		<tr>
			<td width="05%" colspan="05" align="left"> &nbsp</td>
			<td Width="25%" colspan="25" align="left">
				<label class="caption" >Drawing Location</label>
			</td>
			<td Width="75%" colspan="75" align="left">
				<Input Type="Text" Id="txtDrgLocation" name="txtDrgLocation" TabIndex="12"  Size="70" MaxLength="70" >
			</td>
		</tr>
		<tr>
			<td width="05%" colspan="05" align="left"> &nbsp</td>
			<td Width="25%" colspan="25" align="left">
				<label class="caption">Quality Test Type</label>
			</td>
			<td Width="20%" colspan="20" align="left">
				<Select id="drpTestCode" name="drpTestCode" TabIndex="13" >
					<Option Value="0"> Inspection Not Required </Option>
					<Option Value="1"> Visual Inspection </Option>
					<Option Value="2"> QA Testing </Option>
				</select>
			</td>
		</tr>
		<tr>
			<td width="05%" colspan="05" align="left"> &nbsp</td>
			<td Width="25%" colspan="25" align="left">
				<label class="caption">Quality Specification No</label>
			</td>
			<td Width="20%" colspan="20" align="left">
				<Input Type="Text" Id="txtSpecNo" name="txtSpecNo" TabIndex="14"  Size="22" MaxLength="20" >
			</td>
			<td Width="15%" colspan="15" align="left">
				<Label class="Caption">Revision Number</Label>
			</td>
			<td Width="10%" colspan="10" align="left">
				<Input Type="Text" Id="txtSpecRevNo" name="txtSpecRevNo" TabIndex="15"  Size="12" MaxLength="10" value="0" >
			</td>
			<td Width="10%" colspan="10" align="left">
				<Label class="Caption">Rev. Date</Label>
			</td>
			<td Width="15%" colspan="15" align="left">
				<Input Type="Text" Name="txtSpecRevDate" Id="txtSpecRevDate" Size="10" MaxLength="10" Tabindex="16"  OnBlur="chkValidFormatDate(this,'dd/mm/yyyy')" >
				<a href="javascript:showCal('Calendar2')">
				<img src="../../images/cal.gif" width="16" height="16" Border="1" TabIndex="17" ></a>
			</td>
		</tr>
		<tr>
			<td width="05%" colspan="05" align="left"> &nbsp</td>
			<td Width="25%" colspan="25" align="left">
				<label class="caption" >Casting Weight *</label>
			</td>
			<td Width="20%" colspan="20" align="left">
					<Input Type="Text" Id="txtCastingWt" name="txtCastingWt" TabIndex="18"  Size="12" MaxLength="10" value="0.000" OnBlur="ChkInputWt(this)" style="Text-align:Right">
			</td>
			<td Width="15%" colspan="15" align="left">
				<label class="caption" >Finished Weight *</label>
			</td>
			<td Width="10%" colspan="10" align="left">
					<Input Type="Text" Id="txtFinishWt" name="txtFinishWt" TabIndex="19"  Size="12" MaxLength="10" value="0.000" OnBlur="ChkInputWt(this)" style="Text-align:Right">

			</td>
			<td Width="10%" colspan="10" align="left">
				<label class="caption">Rate</label>
			</td>
			<td Width="15%" colspan="15" align="left">
				<Input Type="Text" Id="txtRate" name="txtRate" TabIndex="20"  Size="12" MaxLength="10" value="0" OnBlur='chkValidNoValue(this,0,"Rate");' style="Text-align:Right" >
			</td>
		</tr>
		<tr>
			<td width="05%" colspan="05" align="left"> &nbsp</td>
			<td Width="25%" colspan="25" align="left">
				<label class="caption">Despatch As / Item Type</label>
			</td>
			<td Width="10%" colspan="10" align="left">
				<Input Type="Radio" Id="rdoCasting" name="rdoDespType" TabIndex="21"  Value="1"  runAt="server" class="check" /><b>&nbsp;Casting</b>
			</td>
			<td Width="10%" colspan="10" align="left">
				<Input Type="Radio" Id="rdoFinish"  name="rdoDespType" TabIndex="22" " Value="0" checked runAt="server" class="check" /><b>&nbsp;Finished</b>
			</td>
			<td Width="10%" colspan="10" align="left">
				<Input Type="Radio" Id="rdoAssembly"  name="rdoDespType" TabIndex="23" " Value="2"  runAt="server" class="check" /><b>&nbsp;Assembly</b>
			</td>
		</tr>
		<tr>
			<td width="05%" colspan="05" align="left"> &nbsp</td>
			<td Width="25%" colspan="25" align="left">
				<label class="caption" >Sales classification</label>
			</td>
			<td Width="30%" colspan="30" align="left">
				<Select id="drpSaleAs" name="drpSaleAs"  TabIndex="24" >
				
					<Option Value="101001" >SALES</Option>
					
				</select>
			</td>
		</tr>
		<tr>
			<td width="05%" colspan="05" align="left"> &nbsp</td>
			<td Width="25%" colspan="25" align="left">
				<label class="caption">Chapter Number</label>
			</td>
			<td Width="70%" colspan="70" align="left">
				<Select id="drpChapter" name="drpChapter"  TabIndex="25" >
				
					<Option Value="1010001" >0000 00 00  NO EXCISE</Option>
					
					<Option Value="1010147" >2503 00 10  Refind Sulphur</Option>
					
					<Option Value="1010327" >2523 29 30  CEMENT</Option>
					
					<Option Value="1010264" >2530 10 20  PERLITE ORE</Option>
					
					<Option Value="1010284" >2530 10 20  COMPAX-RESIN</Option>
					
					<Option Value="1010024" >2620 40 10   --- Aluminium dross</Option>
					
					<Option Value="1010136" >2704 00 30  Hard Coke of Coal</Option>
					
					<Option Value="1010069" >2710 19 90  CIRCULATING OIL</Option>
					
					<Option Value="1010028" >2711 19 00   - Liquified: -- Other</Option>
					
					<Option Value="1010308" >2713 11 00  Graphitizied Petroleum Coke</Option>
					
					<Option Value="1010033" >2713 12 00   - Petroleum coke: -- Calcined</Option>
					
					<Option Value="1010249" >2803 00 90  GRAPHITE</Option>
					
					<Option Value="1010062" >2804 21 00  ARGOAN</Option>
					
					<Option Value="1010157" >2811 21 90  Other</Option>
					
					<Option Value="1010036" >2819 19 00   - Of sodium : -- Other</Option>
					
					<Option Value="1010214" >2836 20 20  SODA ASH</Option>
					
					<Option Value="1010091" >2836 20 90  SODA ASH</Option>
					
					<Option Value="1010369" >2836 20 90  2836 20 90</Option>
					
					<Option Value="1010241" >2849 20 90  SILICO CARBIDE</Option>
					
					<Option Value="1010030" >3208 10 30   --- Varnishes (Red - Oxide)</Option>
					
					<Option Value="1010324" >3208 10 90  PAINT</Option>
					
					<Option Value="1010311" >3208 20 90  PAINT</Option>
					
					<Option Value="1010082" >3209 10 10  EMULASION PAINT</Option>
					
					<Option Value="1010025" >3212 90 30   --- Aluminium paste</Option>
					
					<Option Value="1010343" >3402 90 92  Neutracare</Option>
					
					<Option Value="1010149" >34029092  TECHLINE 995 JCN Oil</Option>
					
					<Option Value="1010263" >3403 19 00  CONTAINING PETROLIUM OILS</Option>
					
					<Option Value="1010138" >34039900  Supercut 5050 EP Oil</Option>
					
					<Option Value="1010046" >3505 10 10  Dextrins & Other modified Starches</Option>
					
					<Option Value="1010068" >3801 10 00  GRAPHAITE POWDER</Option>
					
					<Option Value="1010297" >3801 90 00  GRAPHITE FINE</Option>
					
					<Option Value="1010277" >3809 91 90  SUPERCIDE OIL</Option>
					
					<Option Value="1010341" >3811 90 00  other</Option>
					
					<Option Value="1010029" >3814 00 10   --- Organic composite solvents and thinners,</Option>
					
					<Option Value="1010166" >3815 90 00  CATALYST</Option>
					
					<Option Value="1010071" >3816 00 00  WHYTHEAT</Option>
					
					<Option Value="1010022" >3824 10 00   - Prepared binders for foundry moulds or cores</Option>
					
					<Option Value="1010199" >3824 10 10  INOCULANT</Option>
					
					<Option Value="1010034" >3824 40 90   --- Other</Option>
					
					<Option Value="1010174" >3824 90 12  MECATEC EXPRESS</Option>
					
					<Option Value="1010354" >3824 90 90  3824 90 90</Option>
					
					<Option Value="1010175" >3849 20 10  SILICON CARBIDE</Option>
					
					<Option Value="1010331" >3907 30 90  MAHACOAT HR BLACK 250C</Option>
					
					<Option Value="1010125" >3919 10 00  BOPP TAPE.</Option>
					
					<Option Value="1010224" >3919 90 20  BOPE TAPE</Option>
					
					<Option Value="1010124" >39191000  BOPP TAPE</Option>
					
					<Option Value="1010074" >3920 10 12  POLYTHENE SHEET /FILM</Option>
					
					<Option Value="1010269" >3920 10 99  OTHER</Option>
					
					<Option Value="1010047" >3923 10 90  Plastic Crates,Bins & Pallets</Option>
					
					<Option Value="1010073" >3923 21 00  POLYTHENE BAGS / COVERS</Option>
					
					<Option Value="1010070" >3923 90 90  THERMOCOLE PACKING BUFFER</Option>
					
					<Option Value="1010307" >3923 90 90  THERMOCOLE PACKING BUFFER</Option>
					
					<Option Value="1010292" >3923 90 90  PACKAGING BUFFER</Option>
					
					<Option Value="1010293" >3923 90 90  PACKAGING BUFFER</Option>
					
					<Option Value="1010203" >39231090  Plastic scrap</Option>
					
					<Option Value="1010089" >3926 90 29  PLASTIC CARET</Option>
					
					<Option Value="1010332" >4006 90 90  TOP DEGREE SEAL DIA</Option>
					
					<Option Value="1010304" >4010 31 90  V BELT</Option>
					
					<Option Value="1010276" >4016 93 30  RUBBER & PLASTICS RINGS</Option>
					
					<Option Value="1010329" >4016 93 30  SEAL</Option>
					
					<Option Value="1010278" >4016 93 90  OTHER</Option>
					
					<Option Value="1010072" >4016 99 90  INTEGRAL DAMPER</Option>
					
					<Option Value="1010235" >44151000  44151000 WOODEN CASE</Option>
					
					<Option Value="1010027" >4819 10 10   --- Boxes</Option>
					
					<Option Value="1010167" >6804 22 10  D C WHEEL</Option>
					
					<Option Value="1010285" >6804 22 10  GRINDING WHEEL</Option>
					
					<Option Value="1010178" >68042210  68042210</Option>
					
					<Option Value="1010236" >6805 10 10  Abrasive cloth</Option>
					
					<Option Value="1010322" >6806 10 00  CERAMIC FIBER BLANKET</Option>
					
					<Option Value="1010032" >6807 90 90   --- Other ( Resin Coated sand)</Option>
					
					<Option Value="1010222" >6812 92 11  ASBESTOS SHEET</Option>
					
					<Option Value="1010344" >6814 90 90  other</Option>
					
					<Option Value="1010189" >6902 20 90  REMMING MASS</Option>
					
					<Option Value="1010035" >6903 20 10   --- Silicon carbide crucibles</Option>
					
					<Option Value="1010306" >6903 90 30  Ceramic fibres</Option>
					
					<Option Value="1010328" >6903 90 30  CERAMIC BLANKET</Option>
					
					<Option Value="1010372" >6903 90 40  6903 90 40</Option>
					
					<Option Value="1010288" >6903 90 90  CERAMIC FOME FILTER</Option>
					
					<Option Value="1010173" >6909 90 00  CERAMIC FILTER</Option>
					
					<Option Value="1010083" >6909 90 00  CERAMIC FOAM FILTER</Option>
					
					<Option Value="1010172" >6909 90 99  CERAMIC FILTER</Option>
					
					<Option Value="1010213" >6914 90 00  INSULATING SLEEVE</Option>
					
					<Option Value="1010031" >7201 10 00   - Non-alloy pig iron containing by weight 0.5% or less of phosphorus</Option>
					
					<Option Value="1010009" >7202 11 00  - Ferro-manganese : -- Containing by weight more than 2% of carbon</Option>
					
					<Option Value="1010010" >7202 19 00   - Ferro-manganese : -- Other</Option>
					
					<Option Value="1010008" >7202 21 00  FERRO SILICON Containing by weight more than 55% of silicon</Option>
					
					<Option Value="1010011" >7202 29 00   - Ferro-silicon: -- Other</Option>
					
					<Option Value="1010012" >7202 30 00   - Ferro-silico-manganese</Option>
					
					<Option Value="1010295" >7202 36 90  M.S.WASTE & SCRAP</Option>
					
					<Option Value="1010013" >7202 41 00   - Ferro-chromium : -- Containing by weight more than 4% of carbon</Option>
					
					<Option Value="1010014" >7202 49 00   - Ferro-chromium : -- Other</Option>
					
					<Option Value="1010015" >7202 50 00   - Ferro-silico-chromium</Option>
					
					<Option Value="1010042" >7202 70 00   - Ferro-molybdenum</Option>
					
					<Option Value="1010043" >7202 92 00   - Other : -- Ferro-vanadium</Option>
					
					<Option Value="1010066" >7202 99 11  FERRO PHOSPHORUS</Option>
					
					<Option Value="1010346" >7202 99 22  OTHER</Option>
					
					<Option Value="1010342" >7202 99 22  Ferro sil Magnesium</Option>
					
					<Option Value="1010347" >7202 99 32  Chrome</Option>
					
					<Option Value="1010021" >7204 00 12   --- Of copper : ---- Copper scrap,</Option>
					
					<Option Value="1010016" >7204 10 00   - Waste and scrap of cast iron</Option>
					
					<Option Value="1010007" >7204 21 00  Waste & Scrap of Alloy Steel :-- of Stainless Steel</Option>
					
					<Option Value="1010076" >7204 21 90  MS SCRAP</Option>
					
					<Option Value="1010045" >7204 29 90   --- Other (Scrap)</Option>
					
					<Option Value="1010017" >7204 30 00   - Waste and scrap of tinned iron or steel</Option>
					
					<Option Value="1010018" >7204 41 00   - Other waste and scrap : -- Turnings, Milling waste, fillings, trimming</Option>
					
					<Option Value="1010019" >7204 49 00   - Other waste and scrap : -- Other</Option>
					
					<Option Value="1010020" >7204 50 00   - Remelting scrap ingots</Option>
					
					<Option Value="1010312" >7204 90 00  M.S.SCRAP</Option>
					
					<Option Value="1010056" >7204 90 10  SCRAP SALE</Option>
					
					<Option Value="1010037" >7205 10 11   --- Of iron : ---- Shot and angular grit</Option>
					
					<Option Value="1010169" >7205 10 21  STEEL SHOTS</Option>
					
					<Option Value="1010064" >7205 10 90  STEEL SHOTS</Option>
					
					<Option Value="1010272" >7206 10 10  M.S. SCRAP</Option>
					
					<Option Value="1010374" >7207 19 20  Mild steel billets</Option>
					
					<Option Value="1010245" >7208 27 40  HR COIL</Option>
					
					<Option Value="1010296" >7208 36 90  M.S.WASTE & SCRAP</Option>
					
					<Option Value="1010100" >7208 37 40  CHEQURED COIL</Option>
					
					<Option Value="1010254" >7208 38 40  M S SCRAP</Option>
					
					<Option Value="1010253" >7208 39 40  M S SCRAP</Option>
					
					<Option Value="1010262" >7208 52 10  H.R.PLATE</Option>
					
					<Option Value="1010360" >7209 15 90  7209 15 90</Option>
					
					<Option Value="1010366" >7209 16 10  7209 16 10</Option>
					
					<Option Value="1010044" >7209 16 30   --- Strip (Endcut Scrap)</Option>
					
					<Option Value="1010349" >7209 17 30  7209 17 30</Option>
					
					<Option Value="1010093" >7209 18 20  CR MIXED CUT PIECES</Option>
					
					<Option Value="1010363" >7209 18 90  7209 18 90</Option>
					
					<Option Value="1010081" >7209 90 00  CRC SCARP</Option>
					
					<Option Value="1010164" >7209 90 00  CR side slits & CR coil end</Option>
					
					<Option Value="1010065" >7209 99 90  ELMAG 5800</Option>
					
					<Option Value="1010096" >7210 30 90  M.S.SHEET SCRAP</Option>
					
					<Option Value="1010103" >7210 49 00  GI COIL</Option>
					
					<Option Value="1010313" >7210 49 00  G. P. SI COIL</Option>
					
					<Option Value="1010315" >7210 61 00  M.S.AZ COILS SECOND</Option>
					
					<Option Value="1010338" >7210 70 00  SHEET SCRAP</Option>
					
					<Option Value="1010351" >7211 19 40  72111940</Option>
					
					<Option Value="1010084" >7211 19 90  PLATE CUTTING</Option>
					
					<Option Value="1010335" >7211 29 40  HR SLIT PO CTL</Option>
					
					<Option Value="1010209" >7214 10 90  NAS ROUND BAR</Option>
					
					<Option Value="1010326" >7214 20 90  TMT BARS</Option>
					
					<Option Value="1010290" >7216 31 00  M.S. BEAM</Option>
					
					<Option Value="1010151" >7216 50 00  M.S.SCRAP</Option>
					
					<Option Value="1010075" >7216 50 00  MS ANGLES</Option>
					
					<Option Value="1010246" >7216 69 00  SCRAP OF IRON & STEEL</Option>
					
					<Option Value="1010340" >72165000  M.S ISBM BEAM</Option>
					
					<Option Value="1010261" >7219 22 19  M.S PLATE CUTTING (CRC WASTED)</Option>
					
					<Option Value="1010250" >7219 90 90  M.S PLATE CUTTING (CRC WASTED)</Option>
					
					<Option Value="1010325" >7220 11 90  M.S. PLATE CUTTING</Option>
					
					<Option Value="1010194" >7220 20 90  CRC WASTE</Option>
					
					<Option Value="1010223" >7220 90 90  M.S.PLATE CUTTING (CRC WASTAGE)</Option>
					
					<Option Value="1010248" >7222 40 20  M.S PLATE (CRC WASTED)</Option>
					
					<Option Value="1010255" >7225 30 90  HR COIL CUT TO LENGTH</Option>
					
					<Option Value="1010266" >7228 60 92  Spring Steel</Option>
					
					<Option Value="1010200" >7306 10 29  CRC WASTED</Option>
					
					<Option Value="1010359" >7306 90 19  7306 90 19</Option>
					
					<Option Value="1010330" >7306 90 90  M.S. SCRAP /TUBE</Option>
					
					<Option Value="1010353" >7307 19 90  7307 19 90</Option>
					
					<Option Value="1010352" >7307 21 00  7307 21 00</Option>
					
					<Option Value="1010095" >7308 90 10  M.S.PLATES/SCRAP</Option>
					
					<Option Value="1010215" >7308 90 90  Other</Option>
					
					<Option Value="1010160" >7310 10 10  Spares of Container</Option>
					
					<Option Value="1010145" >73110090  Air Receiver</Option>
					
					<Option Value="1010314" >7314 19 10  Wire gauze</Option>
					
					<Option Value="1010133" >7318 11 90  STUD</Option>
					
					<Option Value="1010226" >7318 15 00  BANJO BOLT</Option>
					
					<Option Value="1010370" >7320 90 90  7320 90 90</Option>
					
					<Option Value="1010373" >7320 90 90  7320 90 90</Option>
					
					<Option Value="1010039" >7322 90 10   --- Air heaters and hot air distributors</Option>
					
					<Option Value="1010355" >73239200  Cast Iron, Enamelled</Option>
					
					<Option Value="1010002" >7325 99 10  Other Cast Articals of Iron & Steel</Option>
					
					<Option Value="1010054" >7325 99 10  7325 99 10</Option>
					
					<Option Value="1010247" >7325 99 20  BMD NARROW BLADE</Option>
					
					<Option Value="1010048" >7325 99 99  RAW SG IRON CASTING</Option>
					
					<Option Value="1010171" >7408 19 90  BARE COPPER WIRE</Option>
					
					<Option Value="1010260" >7409 11 00  COPPER STRIPS</Option>
					
					<Option Value="1010152" >74091900   COPPER STRIPS</Option>
					
					<Option Value="1010165" >7502 10 00  NICKEL CATHODES</Option>
					
					<Option Value="1010026" >7601 20 10   - Aluminium alloys : Ingots</Option>
					
					<Option Value="1010289" >76020090   Aluminium Boaring</Option>
					
					<Option Value="1010102" >7616 99 00  ALLUMINUM ELBOW</Option>
					
					<Option Value="1010003" >7616 99 90  Other - Aluminium Casting</Option>
					
					<Option Value="1010077" >8001 10 90  TIN METAL</Option>
					
					<Option Value="1010230" >8200 10 90  BORING BAR</Option>
					
					<Option Value="1010158" >8202 20 00  Band Saw Blade</Option>
					
					<Option Value="1010196" >82021010  Hexa Blade  82021010</Option>
					
					<Option Value="1010233" >82051000  82051000 Consumable Tools</Option>
					
					<Option Value="1010237" >8207 13 00  Tooling Aceessaries</Option>
					
					<Option Value="1010146" >8207 20 00  DIES & CORE BOX</Option>
					
					<Option Value="1010273" >8207 30 00  TOOLS</Option>
					
					<Option Value="1010201" >8207 40 90  TOOLS</Option>
					
					<Option Value="1010057" >8207 50 00  8207 50 00 TOOLS</Option>
					
					<Option Value="1010275" >8207 50 50  HSS TOOLS</Option>
					
					<Option Value="1010281" >8207 60 10  STD EXPANDABLE REMAX TS</Option>
					
					<Option Value="1010181" >8207 80 00  8207 80 00 TOOLS</Option>
					
					<Option Value="1010198" >8207 90 10  TOOLS</Option>
					
					<Option Value="1010185" >8207 90 90  PATTERN</Option>
					
					<Option Value="1010058" >8207 90 90  PATTERN & DIES</Option>
					
					<Option Value="1010139" >82075000  SC Self Centering Drill</Option>
					
					<Option Value="1010183" >82075000  8207 50 00 TOOLS</Option>
					
					<Option Value="1010234" >82076010  82076010 TOOLS</Option>
					
					<Option Value="1010180" >82077010  TOOLS 8207 70 10</Option>
					
					<Option Value="1010059" >8209 00 10  8209 00 10 TOOLS</Option>
					
					<Option Value="1010123" >8209 00 90  8209 00 90 TOOLS</Option>
					
					<Option Value="1010211" >824269990  EOT CRANE PARTS</Option>
					
					<Option Value="1010190" >83025000  Domestic fixtures</Option>
					
					<Option Value="1010090" >8311 10 00  XUPUR 2240</Option>
					
					<Option Value="1010163" >84 74 9000  PARTS OF MACHINE</Option>
					
					<Option Value="1010055" >8409 91 99  Part for Enginer parts</Option>
					
					<Option Value="1010239" >8409 91 99  PARTS OF ENGINE</Option>
					
					<Option Value="1010004" >8409 99 41  Parts Suitable for use Solely or Principally with the Engine - Disel</Option>
					
					<Option Value="1010051" >8409 99 90  Part suitable for use solely or principally with the engine petrol</Option>
					
					<Option Value="1010049" >84099191  Part suitable for use solely or principally with the engine petrol</Option>
					
					<Option Value="1010356" >8412 10 00  84121000</Option>
					
					<Option Value="1010376" >84122990  OTHER</Option>
					
					<Option Value="1010197" >8413 91 90  M.S.SCRAP</Option>
					
					<Option Value="1010176" >84137010  Primarily designed to handle water</Option>
					
					<Option Value="1010321" >8414 40 30  Screw air compressors</Option>
					
					<Option Value="1010184" >8414 40 90  Other</Option>
					
					<Option Value="1010350" >8414 59 10  8414 59 10</Option>
					
					<Option Value="1010128" >8414 59 30  DUST COLLECTOR</Option>
					
					<Option Value="1010186" >8414 90 11  PART OF COMPRESSORS</Option>
					
					<Option Value="1010240" >8414 90 19  Air or Vacuum Pumps and Compressors</Option>
					
					<Option Value="1010144" >84148090  Electricpower Screw Compressor</Option>
					
					<Option Value="1010156" >8417 90 00  PARTS FOR THERMAL SAND RECLAMATION SYATEM</Option>
					
					<Option Value="1010270" >8419 50 20  Assly of PHE</Option>
					
					<Option Value="1010251" >8421 19 99  OTHER</Option>
					
					<Option Value="1010323" >8423 81 90  ELE.WEIGH SCALE</Option>
					
					<Option Value="1010291" >8423 82 90  PARTS OF ELE WEIGH SCALE SPP</Option>
					
					<Option Value="1010242" >8424 89 10  Spraying Equipment,Coponents, & Accessories</Option>
					
					<Option Value="1010208" >8424 90 00  BARE WHEELPLATE R</Option>
					
					<Option Value="1010299" >8425 11 10  WIRE ROPE</Option>
					
					<Option Value="1010336" >8425 11 10  CHAIN ELECTRIC HOIST</Option>
					
					<Option Value="1010137" >8426 11 00  Overhead travelling cranes on fixed support</Option>
					
					<Option Value="1010148" >8426 99 90  Other</Option>
					
					<Option Value="1010348" >8427 90 00  8427 90 00</Option>
					
					<Option Value="1010218" >8428 20 11  Belt Conveyors</Option>
					
					<Option Value="1010094" >8428 20 19  PNEUMATIC CONVEYING SYSTEM</Option>
					
					<Option Value="1010221" >8428 90 00  Others</Option>
					
					<Option Value="1010162" >8428 90 90  Other Parts  suitable for use with particular machine</Option>
					
					<Option Value="1010154" >8431 39 10  PARTS OF ELECTRIC</Option>
					
					<Option Value="1010300" >8431 39 90  Spare & Components of Conveyor Machinery</Option>
					
					<Option Value="1010079" >8432 10 10  DISC PLUGHS</Option>
					
					<Option Value="1010310" >8454 90 00  MACHINERY SPARE</Option>
					
					<Option Value="1010078" >8457 10 20  MACHINARY</Option>
					
					<Option Value="1010099" >8458 11 00  CNC LATHE</Option>
					
					<Option Value="1010098" >84589990   Turning Machine</Option>
					
					<Option Value="1010120" >8459 29 90  Drilling Machine</Option>
					
					<Option Value="1010280" >8459 2950   AIR GAP 4 SENSOR</Option>
					
					<Option Value="1010193" >8459 4020   Boaring Machine</Option>
					
					<Option Value="1010238" >8459 59 90  Pneumatic Tool</Option>
					
					<Option Value="1010301" >8459 70 20  TAPPING MACHINE</Option>
					
					<Option Value="1010204" >845961  SPM MACHINE</Option>
					
					<Option Value="1010362" >8460 90 90  8460 90 90</Option>
					
					<Option Value="1010153" >8461 50 11  Sawing machines</Option>
					
					<Option Value="1010130" >8466 10 10  TOOL HOLDER</Option>
					
					<Option Value="1010061" >8466 10 10  TOOLS</Option>
					
					<Option Value="1010231" >8466 10 20  BORING BAR</Option>
					
					<Option Value="1010202" >8466 10 20  TOOLS</Option>
					
					<Option Value="1010129" >8466 30 10  CHUCKS & CHUCK SPARES</Option>
					
					<Option Value="1010086" >8466 30 20  FIXTURE HYDROLIC BLOCK</Option>
					
					<Option Value="1010361" >8466 30 90  8466 30 90</Option>
					
					<Option Value="1010302" >8466 93 10  PARTS AND ACCESSORIES CYLINDER</Option>
					
					<Option Value="1010159" >8466 93 90  Other</Option>
					
					<Option Value="1010179" >84662000  84662000</Option>
					
					<Option Value="1010256" >8467 11 10  WASHING MACHINE</Option>
					
					<Option Value="1010170" >8467 19 00  BENCH RAMMER</Option>
					
					<Option Value="1010220" >8467 89 20  Vibrators</Option>
					
					<Option Value="1010320" >8467 99 00  SEAL KIT</Option>
					
					<Option Value="1010257" >8471 60 30  HONING MACHINE</Option>
					
					<Option Value="1010150" >8474 80 30  FOUNDRY EQUIPMENTS,MACHINERIES AND ITS SPARES.</Option>
					
					<Option Value="1010087" >8474 80 30  FOUNDRY MACHINE</Option>
					
					<Option Value="1010088" >8474 80 90  FOUNDRY MACHINE PART</Option>
					
					<Option Value="1010131" >8474 90 00  MACHINES/PARTS</Option>
					
					<Option Value="1010140" >84779072  CHUTE MANUFACTURING/FABRICATION</Option>
					
					<Option Value="1010141" >8479 89 99  ROTEX MAKE CYLINDER</Option>
					
					<Option Value="1010345" >8479 90 90  OTHER</Option>
					
					<Option Value="1010191" >84796000  PANEL COOLER</Option>
					
					<Option Value="1010023" >8480 10 00   - Moulding boxes for metal foundry</Option>
					
					<Option Value="1010217" >8480 20 00  Mould Bases</Option>
					
					<Option Value="1010040" >8480 30 00   - Moulding patterns</Option>
					
					<Option Value="1010041" >8480 49 00   - Moulds for metal or metal carbides: -- Other</Option>
					
					<Option Value="1010206" >8480 81 30  INDUSTRIAL VALVES</Option>
					
					<Option Value="1010265" >8481 10 00  PARTS OF ELECTRIC</Option>
					
					<Option Value="1010258" >8481 80 90  MICRO RATIO VALVE</Option>
					
					<Option Value="1010316" >8482 10 20  BEARING</Option>
					
					<Option Value="1010219" >8482 20 11  Tapered roller bearings</Option>
					
					<Option Value="1010080" >8483 30 00  PLAIN SHAFT BEARINGS</Option>
					
					<Option Value="1010339" >8483 30 00  BUSH ASSEMBLY</Option>
					
					<Option Value="1010334" >8483 40 00  WARM SHAFT</Option>
					
					<Option Value="1010283" >8483 60 10  US CI  CPLG</Option>
					
					<Option Value="1010052" >8483 90 00  Parts of Gear Box</Option>
					
					<Option Value="1010005" >8483 99 90  Other Transmission Elements Presented Separately;Parts</Option>
					
					<Option Value="1010298" >8486 90 00  SMC VALUE</Option>
					
					<Option Value="1010142" >85021100  accoustic diesel genset and</Option>
					
					<Option Value="1010168" >8503 00 29  COPPER WIRE SCRAP</Option>
					
					<Option Value="1010287" >8504 10 90  ELECTRICAL PARTS</Option>
					
					<Option Value="1010268" >8504 22 00  FURANE TRANSFORMER</Option>
					
					<Option Value="1010228" >8504 40 10  ELECTRIC INVERTER</Option>
					
					<Option Value="1010267" >8504 40 90  PANEL ACCESSARIES</Option>
					
					<Option Value="1010229" >8504 90 9   OTHER</Option>
					
					<Option Value="1010104" >85042100  Transformer</Option>
					
					<Option Value="1010135" >8505 19 00  ARTICALS IN TO B.P.MAGNET</Option>
					
					<Option Value="1010212" >8505 20 00  A C COIL</Option>
					
					<Option Value="1010333" >8505 90 00  CIRCULAR LIFTING MAGNET</Option>
					
					<Option Value="1010357" >8511 20 90  8511 20 90</Option>
					
					<Option Value="1010207" >8514 30 10  PART OF FURNACE</Option>
					
					<Option Value="1010092" >8514 90 00  COMPONENT OF I.M.F</Option>
					
					<Option Value="1010192" >85176290  85176290 SWITCH -SOARES FOR VMC,CNC M/C</Option>
					
					<Option Value="1010063" >8519 00 00  PART OF OVEN & FURNACE ELECTRIC</Option>
					
					<Option Value="1010177" >85311020  83111020</Option>
					
					<Option Value="1010121" >85321000  LCV CAPACITORS</Option>
					
					<Option Value="1010318" >8534 00 00  Encoder cap</Option>
					
					<Option Value="1010274" >8535 21 21  22kv Combination panel outdoor</Option>
					
					<Option Value="1010294" >8536 20 10  AIR CIRCUIT BREAKE</Option>
					
					<Option Value="1010126" >8536 50 90  PARTS FOR SAND RECLAIMATION SYSTEM</Option>
					
					<Option Value="1010127" >8536 50 90  PARTS SAND RECL</Option>
					
					<Option Value="1010210" >8536 90 90  SWITCHES ,RELAYS & ACCESSORIES</Option>
					
					<Option Value="1010216" >8537 10 00  Voltage not exceeding 1000 V</Option>
					
					<Option Value="1010286" >8538 10 10  CONTROL PARTS</Option>
					
					<Option Value="1010101" >8538 90 00  ACCESSORY</Option>
					
					<Option Value="1010367" >8544 11 90  8544 11 90</Option>
					
					<Option Value="1010364" >8544 20 90  8544 20 90</Option>
					
					<Option Value="1010225" >8544 60 90  ELECTIRCAL MATERIAL  CABLE</Option>
					
					<Option Value="1010375" >85459010  Arc-lamp carbon</Option>
					
					<Option Value="1010182" >87078000  8207 80 00 TOOLS</Option>
					
					<Option Value="1010337" >8708 10 90  M.S.SCRAP</Option>
					
					<Option Value="1010227" >8708 29 00  PARTS OF VEHICALS</Option>
					
					<Option Value="1010067" >8708 94 00  M.V. PARTS</Option>
					
					<Option Value="1010006" >8708 99 00  Parts & Accessories of Motor Vehicle</Option>
					
					<Option Value="1010371" >8708 99 00  8708 99 00</Option>
					
					<Option Value="1010358" >8714 92 90  8714 92 90</Option>
					
					<Option Value="1010050" >8714 94 00  Parts & Accessories of Motor Vehicle</Option>
					
					<Option Value="1010053" >87141900  Parts and Accessories of Motor Vehicle</Option>
					
					<Option Value="1010161" >8716 20 00  Parts of Mechinical and electric material</Option>
					
					<Option Value="1010259" >87169010  Parts & Accessories of Trailers</Option>
					
					<Option Value="1010195" >90158000  Gauges - 90158000</Option>
					
					<Option Value="1010187" >9017 30 00  GAUGES</Option>
					
					<Option Value="1010244" >9017 30 21  Gauges - Plug</Option>
					
					<Option Value="1010155" >9017 30 29  TESTING INSTRUMENTS</Option>
					
					<Option Value="1010282" >9017 80 90  GAUGES</Option>
					
					<Option Value="1010097" >90179000  Relation Gauge</Option>
					
					<Option Value="1010243" >9018 90 29  Gauges - Other</Option>
					
					<Option Value="1010132" >90248099  SPECIAL TESTING MACHINE</Option>
					
					<Option Value="1010305" >9025 19 20  BATTERY BOARD</Option>
					
					<Option Value="1010368" >9025 80 90  9025 80 90</Option>
					
					<Option Value="1010038" >9025 90 00   - Parts and accessories           Measuring Instruments</Option>
					
					<Option Value="1010309" >9027 30 10  SPECTROMETRE  COMPLETE WITH ACEESSARIES</Option>
					
					<Option Value="1010232" >9027 30 90  SPECTRA MACHINE PARTS</Option>
					
					<Option Value="1010252" >9027 80 90  COATING THICKNESS GAUGE</Option>
					
					<Option Value="1010205" >9027 90 90  PARTS FOR SPECTROMETER</Option>
					
					<Option Value="1010105" >90289090  22 KV HT METERING CUBICLE</Option>
					
					<Option Value="1010122" >9031 80 00  CMM MACHINE</Option>
					
					<Option Value="1010365" >9031 80 00  9031 80 00</Option>
					
					<Option Value="1010085" >9031 90 00  RELATIONAL  GUAGES</Option>
					
					<Option Value="1010188" >90311000  REALATION GAUGES</Option>
					
					<Option Value="1010271" >90314900  MEASURING STATION</Option>
					
					<Option Value="1010279" >9032 89 10  Electronic automatic regulators</Option>
					
					<Option Value="1010319" >9032 90 00  PLC CARDS</Option>
					
					<Option Value="1010143" >90328990  consudigital powder conditioner</Option>
					
					<Option Value="1010303" >9033 00 00  MINI TIPS/THERMOCOUPLE</Option>
					
					<Option Value="1010317" >9131 80 00  Encoder BTP</Option>
					
					<Option Value="1010134" >9603 50 50  STEEL WIRE BRUSH</Option>
					
				</select>
			</td>
		</tr>
		<tr>
			<td width="05%" colspan="05" align="left"> &nbsp</td>
			<Td Width="25%" colspan="25" align="left">
				<Label class="caption">Rejection Scrap Material </label>
			</Td>
			<Td Width="70%" colspan="70" align="left">
				
				<Select id="drpScrap" name="drpScrap"  TabIndex="26" >
				
					<Option Value="1010300245" >125 CC CYLINDER BLOCK 179889/10</Option>
					
					<Option Value="1010300244" >3 PORT CYLINDER BLOCK 17009426</Option>
					
					<Option Value="1010300345" >5 PORT BLOCK CD 101009</Option>
					
					<Option Value="1010300243" >5 PORT CYLINDER BLOCK 3721664</Option>
					
					<Option Value="1010300286" >ABS FRONT HUB  264333403702</Option>
					
					<Option Value="1010300267" >ADAPTOR PLATE -CARGO 912 RHD  8043 590 802</Option>
					
					<Option Value="1010300421" >ADAPTOR PLATE CASTING 8033590800</Option>
					
					<Option Value="1010300268" >ADAPTOR PLATE-CARGO 912 LHD  8043 590 803</Option>
					
					<Option Value="1010300039" >AIR COMPRESSOT INTAKE ELBOW 64.54120-0001 (RAW CI) MEPL</Option>
					
					<Option Value="1010300194" >AIR TENATER BRACKET -014</Option>
					
					<Option Value="1010300212" >ALLUMINIUM SCRAP</Option>
					
					<Option Value="1013100017" >ALUMINIUM BORING</Option>
					
					<Option Value="1010300159" >ALUMINIUM DROSS DI</Option>
					
					<Option Value="1010300203" >ALUMINIUM INGOT ALSI 9CU3</Option>
					
					<Option Value="1010300032" >ALUMINIUM INGOT LM-4</Option>
					
					<Option Value="1010300033" >ALUMINIUM INGOT LM-6</Option>
					
					<Option Value="1010300218" >ALUMINIUM INGOTS INGOT AC 4C </Option>
					
					<Option Value="1010300217" >ALUMINIUM INGOTS LM 25</Option>
					
					<Option Value="1010300034" >ALUMINIUM MANGNECIAM</Option>
					
					<Option Value="1010300035" >ALUMINIUM PATRA</Option>
					
					<Option Value="1010300036" >ALUMINIUM R/R L M-4</Option>
					
					<Option Value="1010300037" >ALUMINIUM R/R L M-6</Option>
					
					<Option Value="1013100005" >ALUMINIUM SCRAP </Option>
					
					<Option Value="1010300038" >ALUMINIUM SILICON</Option>
					
					<Option Value="1010300158" >ALUMINIUM TURNING (BORING)</Option>
					
					<Option Value="1010300165" >ALUMINIUM TURNING (BORING) M/C PARTY</Option>
					
					<Option Value="1010300357" >ASSLY SATTELITE GEAR HSG FG 01000198</Option>
					
					<Option Value="1010300386" >BACKPLATE 794388-0003</Option>
					
					<Option Value="1010300407" >BAJAJ EXHAUST MANIOLD KUBOTA SGI  BB 103349</Option>
					
					<Option Value="1010300191" >BAJAJ HUB (FRONT) LH</Option>
					
					<Option Value="1010300192" >BAJAJ HUB (REAR) RH</Option>
					
					<Option Value="1010300193" >BAJAJ KNUCKLE (LH+RH)</Option>
					
					<Option Value="1010300410" >BARINOC INNOCULINE</Option>
					
					<Option Value="1010300025" >BARIUM BEARING INOCULANTSMIN-56</Option>
					
					<Option Value="1013100370" >BATTERY UPS</Option>
					
					<Option Value="1010300343" >BB HOUSING LH SGI</Option>
					
					<Option Value="1010300302" >BB HOUSING LH/RH SET SF01004260  RMOOBB133052</Option>
					
					<Option Value="1010300344" >BB HOUSING RH  SGI</Option>
					
					<Option Value="1010300021" >BENTONITE POWDER </Option>
					
					<Option Value="1010300221" >BM-100 CYL BLOCK</Option>
					
					<Option Value="1010300371" >BORING </Option>
					
					<Option Value="1013100513" >BOTTOM CASTING</Option>
					
					<Option Value="1010300460" >BRACKET (HP LINE SUPPORT) 2527 0714 3701</Option>
					
					<Option Value="1010300084" >BRACKET ALTERNATOR REFIGRATION CPRSR MOUNTING 1883200C3 (RAW SGI)</Option>
					
					<Option Value="1010300359" >BRACKET IN1015    3548741C1</Option>
					
					<Option Value="1010300298" >BRACKET POWERTRAIN STIFFNER(LH SIDE)  178901103704</Option>
					
					<Option Value="1010300292" >BRACKET POWERTRAIN STIFFNER(RH SIDE)  278901103705</Option>
					
					<Option Value="1010300171" >BRAKE DRUM 180   (B131704)</Option>
					
					<Option Value="1010300215" >BRAKE DRUM FRONT AP 1501001 </Option>
					
					<Option Value="1010300153" >BRAKE DRUM FRONT AP 151003 RAW SGI</Option>
					
					<Option Value="1010300316" >BRAKE SPIDER  789071</Option>
					
					<Option Value="1010300331" >BRAKE SPIDER SGI 785606</Option>
					
					<Option Value="1013100568" >BURN SAND (HOPPER)</Option>
					
					<Option Value="1010300189" >BUSH SLEEVE GEAR FRO HSG.</Option>
					
					<Option Value="1010300391" >BUSHING BLOCK 3W4S BAL CODE AA101372 RAW CI </Option>
					
					<Option Value="1010300367" >BUSHING CYLINDER BLOCK (LINER) JZ BAJAJ - JZ521002 RAW </Option>
					
					<Option Value="1010300365" >BUSHING KGKM - JA541004  RAW </Option>
					
					<Option Value="1013100001" >C I  SCRAP </Option>
					
					<Option Value="1013100002" >C I BORING  S/F</Option>
					
					<Option Value="1013100007" >C I BORING CNC </Option>
					
					<Option Value="1010300144" >C I BORING CNC(M/C PARTY)</Option>
					
					<Option Value="1010300002" >C I PIG IRON</Option>
					
					<Option Value="1013100176" >C. I. BORING CNC (SAND MIX & WASTAGE)</Option>
					
					<Option Value="1010300018" >C. I. SCRAP</Option>
					
					<Option Value="1010300154" >C. I. SCRAP (SPILLAGE) DI</Option>
					
					<Option Value="1010300363" >C.I. BLOCKS</Option>
					
					<Option Value="1010300028" >C.I. INOCULANT - 1-3MM</Option>
					
					<Option Value="1010300356" >C.I. INOCULANTS 0.2MM-0.7MM</Option>
					
					<Option Value="1010300156" >C.I.BORING CNC (M/C PARTY)</Option>
					
					<Option Value="1010300004" >C.I.BORING S/F ( M/C PARTY)</Option>
					
					<Option Value="1010300157" >C.I.BORING S/F (M/C PARTY) DI</Option>
					
					<Option Value="1010300003" >C.I.HOME SCRAP (RR)</Option>
					
					<Option Value="1010300176" >CALCIUM CARBIDE</Option>
					
					<Option Value="1010300012" >CALCIUM PETROLIUM COKE ( CPC )</Option>
					
					<Option Value="1010300419" >CARGO DRUM FRONT- AL151242</Option>
					
					<Option Value="1010300420" >CARGO HOB FRONT - AL151243</Option>
					
					<Option Value="1010300141" >CASE FOR U-400 BOTTOM 9150010001 (RAW CI)</Option>
					
					<Option Value="1010300142" >CASE FOR U-500 BOTTOM 95250010001 ( RAW CI)</Option>
					
					<Option Value="1010300143" >CASE FOR U-600 BOTTOM 93250010001</Option>
					
					<Option Value="1010300453" >CAST HOUSING STE ( SP27302 )</Option>
					
					<Option Value="1010300429" >CASTING HOUSING STI 199010065</Option>
					
					<Option Value="1010300330" >CASTING MATERIAL FOR MASTER PATTERN </Option>
					
					<Option Value="1010300399" >CENTER 0428100000 S FOR 400 </Option>
					
					<Option Value="1010300400" >CENTER 0428600000 M FOR 400</Option>
					
					<Option Value="1010300401" >CENTER 0429100000 L FOR 400</Option>
					
					<Option Value="1010300402" >CENTER 0528100000 S FOR 500</Option>
					
					<Option Value="1010300403" >CENTER 0528600000 M FOR 500</Option>
					
					<Option Value="1010300447" >CENTERE 0628100000 S FOR 600 </Option>
					
					<Option Value="1010300448" >CENTERE 0628600000 M1 FOR 600  </Option>
					
					<Option Value="1010300449" >CENTERE 0628850000 M2 FOR 600 </Option>
					
					<Option Value="1010300450" >CENTERE 0629100000 L FOR 600  </Option>
					
					<Option Value="1010300455" >CENTERE 0728100000 S  FOR 700     </Option>
					
					<Option Value="1010300451" >CENTERE 0728600000 M1 FOR WM-WHL 700</Option>
					
					<Option Value="1010300452" >CENTERE 0728850000 M2 FOR WM-WHL 700</Option>
					
					<Option Value="1010300459" >CENTERE 072910000 L  FOR 700                  </Option>
					
					<Option Value="1010300456" >CENTERE 0828100000 S  FOR 800                  </Option>
					
					<Option Value="1010300457" >CENTERE 0828600000 M1 FOR 800                  </Option>
					
					<Option Value="1010300454" >CENTERE 08288500000 M2 FOR 800                  </Option>
					
					<Option Value="1010300458" >CENTERE 0829100000 L  FOR 800                  </Option>
					
					<Option Value="1010300433" >CENTRIFUGAL FILTER  N 5081170</Option>
					
					<Option Value="1010300393" >CERA ALLOY SR 10 %</Option>
					
					<Option Value="1010300398" >CERALOY TIB 5:1 ™</Option>
					
					<Option Value="1010300178" >CHARCOAL</Option>
					
					<Option Value="1013100177" >CI SCRAP INSERT</Option>
					
					<Option Value="1010300155" >COMPRESSOR BRACKET</Option>
					
					<Option Value="1010300007" >COPER SCRAP</Option>
					
					<Option Value="1010300260" >COPPER INGOTS</Option>
					
					<Option Value="1010300265" >COUNTER WEIGHT PART NO 332/7245 </Option>
					
					<Option Value="1010300089" >COVER CAMSHAFT 3239469 (RAW ALU) MEPL</Option>
					
					<Option Value="1010300269" >COVER CASTING  8046 502 141</Option>
					
					<Option Value="1010300091" >COVER CRANKCASE 325099A (RAW ALU)</Option>
					
					<Option Value="1010300308" >CRANK CASE CASTING AK  20188  RAW  </Option>
					
					<Option Value="1010300057" >CRANK SHAFT 9119056916 (RAW SGI) MEPL</Option>
					
					<Option Value="1010300361" >CRANK SHAFT CASTING 22774C</Option>
					
					<Option Value="1010300362" >CRANK SHAFT CASTING 22774E</Option>
					
					<Option Value="1010300210" >CRANKCASE COVER 325099A (RAW ALU)</Option>
					
					<Option Value="1010300013" >CRCA SCRAP</Option>
					
					<Option Value="1010300229" >CUMMINS VAN PUMP HSG(C.I.) 7673-001-801/20</Option>
					
					<Option Value="1010300231" >CUMMINS VANE PUMP HSG (SGI) 7673-001-821/20</Option>
					
					<Option Value="1013100138" >CUT-OFF WHEEL SCRAP</Option>
					
					<Option Value="1010300309" >CYLINDER  HEAD CASTING BIG AK 24202  RAW </Option>
					
					<Option Value="1010300247" >CYLINDER HEAD (KUBOTA)</Option>
					
					<Option Value="1010300314" >CYLINDER HEAD 24225</Option>
					
					<Option Value="1010300310" >CYLINDER HEAD CASTING SMALL   AK  24201 RAW</Option>
					
					<Option Value="1010300412" >DECK LIFT CRANK 525465501  (DRG 510022501)</Option>
					
					<Option Value="1010300413" >DECK LIFT LEVER   525465502 (DRG 510022502)</Option>
					
					<Option Value="1010300340" >DELUX HUB DLX-6667 C</Option>
					
					<Option Value="1010300172" >DEPB LICENCE </Option>
					
					<Option Value="1010300303" >DIFFERENCIAL HSG BIPOD BO98132630101</Option>
					
					<Option Value="1010300305" >DIFFERENTIAL HSG B09 817 353 00 01</Option>
					
					<Option Value="1010300324" >DN8 PIVOT BLOCK  - 790503/HJ</Option>
					
					<Option Value="1010300252" >DRIVE SHAFT 332/ W3896 -</Option>
					
					<Option Value="1010300258" >DRIVE SHAFT LP BLACK POWDER COATING 332/W3896 (8390/8391)</Option>
					
					<Option Value="1010300259" >DRIVE SHAFT LP YELLOW FL BLACK SH POWDER COAT 332/3896</Option>
					
					<Option Value="1010300254" >DRIVE SHAFT SHORT 332/ X 5820-</Option>
					
					<Option Value="1010300253" >DRIVEN SPROCKET 332-U4307 (29T)</Option>
					
					<Option Value="1010300397" >DRUM BRAKE BH 131023 CI RAW </Option>
					
					<Option Value="1010300395" >DRUM BRAKE BH 131023 CI RAW </Option>
					
					<Option Value="1010300140" >DRUM BRAKE CAST IRON SEMIFINISH 22151106 (RAW SFMC CI)</Option>
					
					<Option Value="1010300167" >DRUM BRAKE REAR AL151093 ( RAW SGI )</Option>
					
					<Option Value="1010300423" >DUCT PIPE DOSER OUTLET 7096492C2 RAW </Option>
					
					<Option Value="1010300264" >ELBOW (INTAKE MANIFOLD) TD2000 RAW B-00-804-141-06-01</Option>
					
					<Option Value="1010300377" >ELBOW TURBO OUTLET 1890074C2 </Option>
					
					<Option Value="1010300148" >ELMAG 5800 FERRO SILICON MANGSIUM</Option>
					
					<Option Value="1010300184" >EMPTY BARRAL FOR CUTTING</Option>
					
					<Option Value="1010300202" >EMPTY DRUM SMALL FOR CUTTING</Option>
					
					<Option Value="1013100122" >EMPTY PATRA BARREL</Option>
					
					<Option Value="1013100240" >EMPTY PLASTIC BARDAN (BAG)</Option>
					
					<Option Value="1013100106" >EMPTY PLASTIC BARRAL</Option>
					
					<Option Value="1013100108" >EMPTY PLASTIC BUCKET</Option>
					
					<Option Value="1013100104" >EMPTY PLASTIC CAN</Option>
					
					<Option Value="1013100302" >EMPTY PLASTIC CAN CAP -10 LTR</Option>
					
					<Option Value="1013100304" >EMPTY PLASTIC CAN CAP-5 LTR</Option>
					
					<Option Value="1013100345" >EMPTY SCRAP TIN </Option>
					
					<Option Value="1010300323" >END  COVER CASTING  8000502001</Option>
					
					<Option Value="1010300270" >END COVER 8046 CASTING  8046 502 001</Option>
					
					<Option Value="1010300271" >END COVER CASTING -003  8046 502 003</Option>
					
					<Option Value="1010300248" >ENG.MTG.NKT.LH 3604</Option>
					
					<Option Value="1010300293" >ENGINE MOUNTING ARM-LEFT  278922123701</Option>
					
					<Option Value="1010300294" >ENGINE MOUNTING ARM-RIGHT  278922123702</Option>
					
					<Option Value="1010300238" >ENGINE MTG ARM LH B09 808 223 2904</Option>
					
					<Option Value="1010300239" >ENGINE MTG ARM LH B09 808 223 3004</Option>
					
					<Option Value="1010300342" >ENGINE MTG BKT FRONT EXHAUST 64.19210-0003</Option>
					
					<Option Value="1010300341" >ENGINE MTG BKT FRONT INLET 64.19210-0002</Option>
					
					<Option Value="1013100738" >EWASTAGE </Option>
					
					<Option Value="1010300299" >EXHAUST MANIFOLD  278914113701</Option>
					
					<Option Value="1010300437" >EXHAUST MANIFOLD  CASTING  CM 3773 Z</Option>
					
					<Option Value="1010300431" >EXHAUST MANIFOLD - CM3738</Option>
					
					<Option Value="1010300300" >EXHAUST MANIFOLD (3713) 254714113713  254714113713</Option>
					
					<Option Value="1010300445" >EXHAUST MANIFOLD -252714113727</Option>
					
					<Option Value="1010300444" >EXHAUST MANIFOLD -278914113705</Option>
					
					<Option Value="1010300297" >EXHAUST MANIFOLD 4DL TC  254714113704</Option>
					
					<Option Value="1010300442" >EXHAUST MANIFOLD 570614113701</Option>
					
					<Option Value="1010300404" >EXHAUST MANIFOLD CYL 1-3 64.08102-0720</Option>
					
					<Option Value="1010300149" >EXHAUST MANIFOLD REAR 1844085C1 (RAW SGI)</Option>
					
					<Option Value="1010300164" >EXHAUST PIPE 0127 SEMIFINISH</Option>
					
					<Option Value="1010300100" >EXHAUST PIPE AFTER TURBO HCI MANIFOLD 62152010126 (RAW CI)</Option>
					
					<Option Value="1010300105" >FAN BEARING HOUSING 1850298C1 (RAW SGI)</Option>
					
					<Option Value="1010300017" >FEERO MOLY</Option>
					
					<Option Value="1010300358" >FERRO BORON</Option>
					
					<Option Value="1010300010" >FERRO CHROMIUM</Option>
					
					<Option Value="1010300006" >FERRO MANGANES</Option>
					
					<Option Value="1010300347" >FERRO PHOSPHORUS</Option>
					
					<Option Value="1010300005" >FERRO SILICON</Option>
					
					<Option Value="1010300026" >FERRO SILICON INOCULANT(GRANUALS)</Option>
					
					<Option Value="1010300031" >FERRO SILICON MAGNESIUM</Option>
					
					<Option Value="1010300185" >FILTER BODY (WAUKESHU)3342636</Option>
					
					<Option Value="1010300284" >FIP SUPPORT PLATE  252707123705</Option>
					
					<Option Value="1010300446" >FIP SUPPORT PLATE 253407123706</Option>
					
					<Option Value="1010300162" >FLEET GUARD FILTER 870006799</Option>
					
					<Option Value="1010300405" >FLYWHEEL  EXP396 CHHEDA ELECTRICALS </Option>
					
					<Option Value="1010300226" >FLYWHEEL 12E225-10</Option>
					
					<Option Value="1010300214" >FLYWHEEL MACHINING N2040336</Option>
					
					<Option Value="1010300139" >FLYWHEEL SEMIFINISH 02 038 40491 ( RAW SFMC CI)</Option>
					
					<Option Value="1010300196" >FRONT ENG.BRACKET LH-054</Option>
					
					<Option Value="1010300195" >FRONT ENG.BRACKET RH-064</Option>
					
					<Option Value="1010300285" >FRONT HUB  264133403708</Option>
					
					<Option Value="1010300461" >FRONT HUB -554533103701 </Option>
					
					<Option Value="1010300406" >FRONT HUB BH131021 GREEN SAND </Option>
					
					<Option Value="1010300169" >FRONT REAR BRAKE DRUM OF SIGN</Option>
					
					<Option Value="1010300311" >FRONT WHEEL HUB  24171128</Option>
					
					<Option Value="1010300234" >FRONT WHEEL HUB (EXCEL-2) T-00686-334-00-01</Option>
					
					<Option Value="1010300233" >FRONT WHEEL HUB (M/C) SMOOTH  T-006863-340-01-01</Option>
					
					<Option Value="1010300232" >FRONT WHEEL HUB (T1 CALIPER) B-00-820-334-09-01</Option>
					
					<Option Value="1010300322" >FRONT WHEEL HUB AA151047</Option>
					
					<Option Value="1010300388" >GARINOCUALTN SR – 50 </Option>
					
					<Option Value="1010300389" >GARINOCULANT SR –E</Option>
					
					<Option Value="1010300016" >GRAPHITE POWDER</Option>
					
					<Option Value="1013100066" >GRINDING WHEEL SCRAP</Option>
					
					<Option Value="1010300296" >GUIDE PLATE REAR SPRING  284532407103</Option>
					
					<Option Value="1013100127" >HAND GLOVES SCRAP</Option>
					
					<Option Value="1010300198" >HATZ CYLINDER BLOCK -0901</Option>
					
					<Option Value="1010300200" >HATZ CYLINDER BLOCK -0911</Option>
					
					<Option Value="1010300199" >HATZ CYLINDER BLOCK -0941</Option>
					
					<Option Value="1010300201" >HATZ CYLINDER BLOCK -1081</Option>
					
					<Option Value="1010300272" >HOUSING - L H  7340 501 837</Option>
					
					<Option Value="1010300312" >HOUSING CASTING - 7340501839</Option>
					
					<Option Value="1010300273" >HOUSING CASTING (IT-MOD)  7340 501 805</Option>
					
					<Option Value="1010300328" >HOUSING CASTING M & M 63 DEGREE  7340501851 ( ZF ) </Option>
					
					<Option Value="1010300274" >HOUSING CASTING RH 8037-004  8037 501 004</Option>
					
					<Option Value="1010300275" >HOUSING CASTING- TWIN CYLINDER  8000 501 001</Option>
					
					<Option Value="1010300152" >HOUSING CLUTCH G2081420 RAW SGI</Option>
					
					<Option Value="1010300276" >HOUSING COVER CASTING -806  8046 502 806</Option>
					
					<Option Value="1010300277" >HOUSING RH- 8046 501 006  8046 501 006</Option>
					
					<Option Value="1010300438" >HOUSING THUNDER BOLT DIAMLER 7674001005</Option>
					
					<Option Value="1010300278" >HSG CASTING (NEW HOLLAND)  7340 501 809</Option>
					
					<Option Value="1010300385" >HSG CASTING 4 HOLE  DRILL REAM 8043002113/30</Option>
					
					<Option Value="1010300279" >HSG CASTING ET / PT  7340 501 803</Option>
					
					<Option Value="1010300280" >HSG CASTING ET / PT BAAGBHAN  7340 501 848</Option>
					
					<Option Value="1010300281" >HSG COVER CASTING 8043  8043 502 107</Option>
					
					<Option Value="1010300179" >HUB FRONT 4 WH BF 131731</Option>
					
					<Option Value="1010300174" >HUB FRONT 4 WH BF 131731</Option>
					
					<Option Value="1010300394" >HUB FRONT BH 131021 SGI RAW </Option>
					
					<Option Value="1010300396" >HUB FRONT BH 131021 SGI RAW </Option>
					
					<Option Value="1010300069" >HUB FRONT WHEEL 24171136 (RAW SGI) MEPL</Option>
					
					<Option Value="1010300237" >HUB HOUSING A00 005 302 65 11</Option>
					
					<Option Value="1010300418" >HUB MACHINING 10 X 335 TM O/B SINGLE RIM 785607 DRG NO 785602</Option>
					
					<Option Value="1010300333" >HUB MACHINING 10 X 335 TP OB  789004</Option>
					
					<Option Value="1010300173" >HUB REAR 4 WH BF 131725</Option>
					
					<Option Value="1010300409" >HUB REAR 4 WH BF 131758</Option>
					
					<Option Value="1010300216" >HUB REFL (BAJAJ AUTO TRAILLING ARM)</Option>
					
					<Option Value="1010300360" >I334 ELBOW,TURBO OUTLET 1890074C2</Option>
					
					<Option Value="1010300370" >INEL -FLYWHEEL N20 40924 </Option>
					
					<Option Value="1010300024" >INOCULANT  - SBC 1-3MM</Option>
					
					<Option Value="1010300426" >INOCULANT  RESEED</Option>
					
					<Option Value="1010300175" >INOCULANT MIN -56 (BARIUM BASE)</Option>
					
					<Option Value="1010300346" >INOCULANT SBC 0.2 - 0.7 MM</Option>
					
					<Option Value="1010300180" >INSERT  CASTING  </Option>
					
					<Option Value="1010300390" >INSERT C.C.R.E (AN 200 CC WH 4S) AN101128  RAW CI</Option>
					
					<Option Value="1010300366" >INSERT CI RING CRANK CASE XCD 135 - JD541005 RAW</Option>
					
					<Option Value="1010300349" >INSERT CI RING CRANK CASE XCD DD101403</Option>
					
					<Option Value="1010300373" >INSERT REAR BRAKE DRUM DG 151079</Option>
					
					<Option Value="1010300222" >INTAKE MANIFOLD CASTING (TD2650F)</Option>
					
					<Option Value="1010300220" >INTAKE MANIFOLD TD 2650 FTI ( RAW ALUMINUM)</Option>
					
					<Option Value="1010300262" >INTAKE MANIFOLD TD2000 MFC (1035) RAW  B-00-804-141-05-01</Option>
					
					<Option Value="1010300321" >INTAKE MANIFOLD TRACTOR 3CYL B-008041410701</Option>
					
					<Option Value="1010300355" >INTAKE MANIFOLD TRACTOR OX45 (RAW)</Option>
					
					<Option Value="1010300335" >K-70 BOXER</Option>
					
					<Option Value="1013100767" >LADDLE WESTAGE SLAGE</Option>
					
					<Option Value="1010300353" >LINER CYL BLOCK INTEGRAL AN 101296</Option>
					
					<Option Value="1010300352" >LINER CYL BLOCK JN 135 JF 521001</Option>
					
					<Option Value="1010300350" >LINER CYLINDER (INTEGRAL) JA521003</Option>
					
					<Option Value="1010300441" >LINER CYLINDER BLOCK C101 JH521003</Option>
					
					<Option Value="1010300439" >LINER CYLINDER INTEGRAL TYPE DJ101182</Option>
					
					<Option Value="1010300440" >LINER CYLINDER INTEGRAL TYPE DK101089</Option>
					
					<Option Value="1010300351" >LINER CYLINDER K60 DS 101182</Option>
					
					<Option Value="1010300348" >LINER FOR CYLINDER BLOCK 52310278</Option>
					
					<Option Value="1010300146" >LUMPY - LMC-COKE POWDER DI</Option>
					
					<Option Value="1013100006" >M S SCRAP </Option>
					
					<Option Value="1010300266" >M.S. ROUND BAR 16 MM</Option>
					
					<Option Value="1010300001" >M.S. SCRAP</Option>
					
					<Option Value="1010300382" >M.S. TURNING BRICKET 18CRNIM07</Option>
					
					<Option Value="1010300381" >M.S. TURNING BRICKET 20MNCR5</Option>
					
					<Option Value="1013100551" >M.S.PATRA SCRAP</Option>
					
					<Option Value="1010300249" >M.S.STEEL</Option>
					
					<Option Value="1010300368" >MACHINING -DEFECTIVE SCRAP (REJECTION)</Option>
					
					<Option Value="1010300207" >MAN MANIFOLD 135</Option>
					
					<Option Value="1010300225" >MANIFOLD 265</Option>
					
					<Option Value="1010300318" >MANIFOLD 3018581</Option>
					
					<Option Value="1010300319" >MANIFOLD 3018582</Option>
					
					<Option Value="1010300320" >MANIFOLD 3018583</Option>
					
					<Option Value="1010300151" >MANIFOLD 704</Option>
					
					<Option Value="1010300150" >MANIFOLD 750</Option>
					
					<Option Value="1010300415" >MANIFOLD EXH FRONT 7098428C2</Option>
					
					<Option Value="1010300422" >MANIFOLD EXH MID 7099296C1 RAW </Option>
					
					<Option Value="1010300416" >MANIFOLD EXH MIDDLE  7098605C2</Option>
					
					<Option Value="1010300379" >MANIFOLD EXH REAR 7097886C1</Option>
					
					<Option Value="1010300417" >MANIFOLD EXH REAR 7098611C2</Option>
					
					<Option Value="1010300177" >MANIFOLD EXHAUST MIDDLE 3015403</Option>
					
					<Option Value="1010300118" >MANIFOLD EXHAUST REAR 1883380C3 (RAW SGI) MEPL</Option>
					
					<Option Value="1010300236" >MANIFOLD EXHAUST REAR 1883380C4 (RAW SGI)</Option>
					
					<Option Value="1010300338" >MANIFOLD FRONT 7095196</Option>
					
					<Option Value="1010300337" >MANIFOLD MIDDLE 7095195</Option>
					
					<Option Value="1010300375" >MANIFOLD MIDDLE 7098023 </Option>
					
					<Option Value="1010300336" >MANIFOLD REAR 7095194</Option>
					
					<Option Value="1013100234" >META CUP SCRAP</Option>
					
					<Option Value="1010300223" >NAVISTAR PULLEY 7090590</Option>
					
					<Option Value="1010300009" >NICKEL</Option>
					
					<Option Value="1010300383" >NTN HOUSING 1881</Option>
					
					<Option Value="1010300242" >OIL FILLER NECK RAW 8080160129 </Option>
					
					<Option Value="1010300126" >OIL PUMP COVER 13.0L 62051035038 (RAW CI)</Option>
					
					<Option Value="1010300166" >OIL PUMP COVER 13.0L 62051035038 (RAW CI)</Option>
					
					<Option Value="1010300241" >OIL SEAL BRACKET RAW B198080140133</Option>
					
					<Option Value="1013100715" >OLD SCRAP MACHINERY</Option>
					
					<Option Value="1010300188" >ORDINARY GRAY CASTING - PLATE</Option>
					
					<Option Value="1010300030" >PERLITE ORE</Option>
					
					<Option Value="1010300008" >PHOSPOROUS</Option>
					
					<Option Value="1010300019" >PIHKOL-A</Option>
					
					<Option Value="1010300020" >PIHKOL-C</Option>
					
					<Option Value="1010300306" >PLANATORY HSG SMALL B09 817 354 00 09</Option>
					
					<Option Value="1010300304" >PLANETORY  HSG BALWAN BO98173540309</Option>
					
					<Option Value="1013100457" >PLASTIC SCARP</Option>
					
					<Option Value="1013100344" >PLASTIC SCRAP</Option>
					
					<Option Value="1010300197" >POWER TECH OFF BRACKET 940806300024</Option>
					
					<Option Value="1010300369" >PRESEED 0-10MM ( PRECONDITIONER)</Option>
					
					<Option Value="1010300235" >PULLEY (FOR ZF PSRTG.PUMP) 7017</Option>
					
					<Option Value="1010300290" >PULLEY (SINGLE GROOVE) WATER PUMP BS III  252720147013</Option>
					
					<Option Value="1010300434" >PULLEY FOR HYDRAULIC PUMP   B 008040320404</Option>
					
					<Option Value="1010300136" >PULLEY HIGH PRESSURE PUMP 3005826C1 (RAW CI)</Option>
					
					<Option Value="1010300295" >PULLEY- WATER PUMP (3 GROOVE)  253420117005</Option>
					
					<Option Value="1010300325" >PULLY GROOVED CRANK SHAFT 3018590C1(FAN DRIVE NEW)</Option>
					
					<Option Value="1010300435" >PUMP PULLEY  B 008040320304</Option>
					
					<Option Value="1010300138" >PUNCHING/SPILLAGE</Option>
					
					<Option Value="1010300334" >RAW CASTING CI</Option>
					
					<Option Value="1010300187" >RAW CASTING SGI</Option>
					
					<Option Value="1010300289" >RAW PART BRACKET HYD PUMP  25252340330410</Option>
					
					<Option Value="1010300283" >RAW PART FIP SUPPORT PLATE.  25250712370210</Option>
					
					<Option Value="1010300246" >REAR BRAKE DRUM -KUMAR RAW</Option>
					
					<Option Value="1010300287" >REAR HUB (RAS104) RAW PART  26613560371010</Option>
					
					<Option Value="1010300288" >REAR HUB (WITH SINGLE INNER MATERIAL SEAL)  266135603716</Option>
					
					<Option Value="1010300147" >RESEED</Option>
					
					<Option Value="1010300443" >RESIN COATED SAND 1.8%</Option>
					
					<Option Value="1010300163" >ROCKER ARM COVER 320099A</Option>
					
					<Option Value="1013100112" >ROUGH FILE SCRAP</Option>
					
					<Option Value="1013100720" >RUBBER CONVEYOR BELT SCRAPED</Option>
					
					<Option Value="1013100003" >S G IRON SCRAP MOLY CONTAIN</Option>
					
					<Option Value="1013100004" >S G IRON SCRAP WITHOUT MOLY </Option>
					
					<Option Value="1010300206" >S.G. IRON BOARING WITHOUT MOLLY</Option>
					
					<Option Value="1010300015" >S.G. MOLY  BOARING</Option>
					
					<Option Value="1010300014" >S.G. PIG IRON</Option>
					
					<Option Value="1013100015" >S.G.IRON BORING MOLY CONTAIN</Option>
					
					<Option Value="1013100016" >S.G.IRON BORING WITHOUT MOLY CONTAIN</Option>
					
					<Option Value="1010300161" >S.G.IRON SCRAP MOLY CONTAIN</Option>
					
					<Option Value="1010300160" >S.G.IRON SCRAP WITHOUT MOLY</Option>
					
					<Option Value="1010300205" >SATELITE GEAR HOUSING  38032722 (RAW SGI)</Option>
					
					<Option Value="1010300376" >SATELITE GEAR HOUSING RE AA131033 (RAW)</Option>
					
					<Option Value="1010300317" >SATELITE GEAR HSG FG01000198  </Option>
					
					<Option Value="1013100461" >SCRAP A C</Option>
					
					<Option Value="1013100293" >SCRAP B2 CUTTER</Option>
					
					<Option Value="1013100782" >SCRAP DC WHEEL </Option>
					
					<Option Value="1013100560" >SCRAP DRILL/TAP TOTALLY BORKEN</Option>
					
					<Option Value="1013100636" >SCRAP ELECTRIC MOTOR</Option>
					
					<Option Value="1013100123" >SCRAP G I SHEET</Option>
					
					<Option Value="1013100757" >SCRAP GAUGES</Option>
					
					<Option Value="1013100559" >SCRAP INSERT TOTALLY BORKEN</Option>
					
					<Option Value="1013100175" >SCRAP PLASTIC CRATE</Option>
					
					<Option Value="1013100669" >SCRAP RUBBER BELT</Option>
					
					<Option Value="1013100306" >SCRAP RUBBER MATERIAL</Option>
					
					<Option Value="1013100819" >SCRAP SHOT BLASTING MACHINE SPARES</Option>
					
					<Option Value="1010300327" >SEAVE  PULLY (PCD 560)</Option>
					
					<Option Value="1010300022" >SG BOARING</Option>
					
					<Option Value="1010300023" >SG HOME SCRAP (RR)</Option>
					
					<Option Value="1010300301" >SG SATELITE HOUSING (AA)  FG00000104</Option>
					
					<Option Value="1013100208" >SHOT BLASTING DUST</Option>
					
					<Option Value="1010300227" >SILICON CARBIDE </Option>
					
					<Option Value="1010300029" >SLAG 30</Option>
					
					<Option Value="1010300432" >SLEEVE CYLINDER  R 1010159</Option>
					
					<Option Value="1010300424" >SLEEVE CYLINDER K3011389</Option>
					
					<Option Value="1010300427" >SLEEVE CYLINDER N 9011619</Option>
					
					<Option Value="1010300425" >SLEEVE CYLINDER P6010149</Option>
					
					<Option Value="1010300137" >SODA</Option>
					
					<Option Value="1010300168" >SPACER FOR BOOSTER  8564210052 ( RAW ALU)</Option>
					
					<Option Value="1010300326" >SPACER SLEEVE P.E. 84C608189</Option>
					
					<Option Value="1010300384" >SPACER TURBO EXH OUTLET 3005498C1</Option>
					
					<Option Value="1013100773" >SPECTRO SAMPLE PIECE</Option>
					
					<Option Value="1010300255" >SPROCKET DRIVEN 331 / 19968 -</Option>
					
					<Option Value="1010300190" >START LEVER CON.BUSH 22101684</Option>
					
					<Option Value="1010300374" >STEEL GRADE PIG IRON</Option>
					
					<Option Value="1010300329" >STEERING GEAR MOUNTING BKT 8043590800</Option>
					
					<Option Value="1010300315" >STRG MTG BKT MFC (1035) RAW </Option>
					
					<Option Value="1010300211" >SULPHUR  GRANULES</Option>
					
					<Option Value="1010300408" >SULPHUR POWDER</Option>
					
					<Option Value="1010300145" >SUPER SEED 50 (INNOCULINE)</Option>
					
					<Option Value="1010300354" >SUPERDEED EXTRA 0.2 - 0.7</Option>
					
					<Option Value="1010300027" >SUPERSEED EXTRA  SIZE-1 - 3 MM</Option>
					
					<Option Value="1010300282" >SUPPORT (FIP - BS-II)  252507123702</Option>
					
					<Option Value="1010300436" >SUPPORT BRACKET,POWER STEERING PUMP  253423403714</Option>
					
					<Option Value="1010300380" >SUPPORT LT RR 3548741C1</Option>
					
					<Option Value="1010300291" >SUPPORT REAR SHACKLE  284532403701</Option>
					
					<Option Value="1010300411" >SUPPORT REAR SHACKLE  284532403702</Option>
					
					<Option Value="1010300339" >SUPPORT VALVE EGR BKT 7095309</Option>
					
					<Option Value="1010300307" >SWING YOKE OX-25  B09 875 386 01 19</Option>
					
					<Option Value="1010300224" >TACO HUB (SMALL) 332/X6020</Option>
					
					<Option Value="1010300213" >TACO HUB LP  PART NO. 333/ P 3936 </Option>
					
					<Option Value="1010300256" >TAPER ROLLER BEARING - 32011</Option>
					
					<Option Value="1010300257" >TAPER ROLLER BEARING - 32012</Option>
					
					<Option Value="1010300186" >TELCO MANIFOLD 3713</Option>
					
					<Option Value="1010300208" >TEST RAW 1</Option>
					
					<Option Value="1010300209" >TEST RAW 2</Option>
					
					<Option Value="1010300332" >TEST RAW MATERIAL TEST</Option>
					
					<Option Value="1010300011" >TIN</Option>
					
					<Option Value="1010300378" >TIN INGOTS</Option>
					
					<Option Value="1010300183" >TVS FOUR STROKE CYL. BLOCK G4010168 ( MACHINED)</Option>
					
					<Option Value="1013100445" >USED OIL (SCRAP)</Option>
					
					<Option Value="1010300230" >VAN PUMP HSG 304 (C.I.) 7673-001-215/20</Option>
					
					<Option Value="1010300228" >VAN PUMP HSG 380 (C.I.) 7672-001-162/20</Option>
					
					<Option Value="1010300392" >VANE PUMP 380 (GGG-50) WITH NAME PLATE 7672 501 806</Option>
					
					<Option Value="1010300364" >VANE PUMP ASHOK LEYLOND 7672 001 825/40</Option>
					
					<Option Value="1010300250" >VANE PUMP ASHOK LEYLOND 7672-501-801</Option>
					
					<Option Value="1010300387" >VANE PUMP SGI 380  PART NO 7672501803 </Option>
					
					<Option Value="1010300313" >VANEDIUM</Option>
					
					<Option Value="1010300170" >VARROC FLY WHEEL 02 116 40522</Option>
					
					<Option Value="1013100082" >WASTAGE</Option>
					
					<Option Value="1013100298" >WASTAGE (BHANGAR)</Option>
					
					<Option Value="1013100494" >WASTAGE BOX (CORUGATE)</Option>
					
					<Option Value="1013100065" >WASTAGE CORUGATED BOXES (SCRAP)</Option>
					
					<Option Value="1013100526" >WASTAGE SCRAP</Option>
					
					<Option Value="1013100466" >WASTE CRUSIBLE</Option>
					
					<Option Value="1010300263" >WATER PUMP HOUSING OM616 RAW A-0000-420-10-501</Option>
					
					<Option Value="1010300372" >WATER PUMP HSG ALU A-0030-807-00-011 ( RAW)</Option>
					
					<Option Value="1013100021" >WESTAGE SAND  </Option>
					
					<Option Value="1013100084" >WESTAGE SLAGE</Option>
					
					<Option Value="1013100085" >WESTAGE SLAGE (M)</Option>
					
					<Option Value="1013100328" >WODDEN SCARP</Option>
					
					<Option Value="1013100582" >WOODEN SCRAP</Option>
					
					<Option Value="1010300261" >XLN CYLINDER TVS BLOCK 70 CC - P1010118</Option>
					
				</select>
			</Td>
		</tr>
		<tr>
			<td width="05%" colspan="05" align="left"> &nbsp</td>
			<td Width="25%" colspan="25" align="left">
				<label class="caption" >Purchase GL</label>
			</td>
			<td Width="70%" colspan="70" align="left">
				<Select id="drpPurhGlAcNo" name="drpPurhGlAcNo"  TabIndex="27" >
				<Option Value="0">&nbsp;</Option>
				
						<Option Value="101001032| 0 | 0" >ACMA CLUSTER EXPENSES   MFPL</Option>

						<Option Value="101001023| 0 | 0" >ADVANCE LAPS (SALARY)   MFPL</Option>

						<Option Value="101001125| 0 | 0" >ADVANCE W/OFF - (DWARKADAS SHAMKUMAR TEXTILES PVT.LTD.   MFPL</Option>

						<Option Value="101000082| 0 | 0" >ADVERTISEMENT & PUBLICITY   com</Option>

						<Option Value="101000901| 0 | 0" >ADVOCATE FEES   </Option>

						<Option Value="101000255| 0 | 0" >ANNEALING  CHARGES   msipl</Option>

						<Option Value="101000040| 0 | 0" >APPRICIATION VALUE OF SHARE   MEPL</Option>

						<Option Value="101000330| 0 | 0" >ASSEMENT DUES (GOVT. AGENCIES)   MFPL</Option>

						<Option Value="101000761| 0 | 0" >AUDIT FEES   MSIPL</Option>

						<Option Value="101000006|101140071|0" >AUTO TRUCK TRIALOR   DI</Option>

						<Option Value="101000084| 0 | 0" >BAD & DOUBTFUL DEBTS   com</Option>

						<Option Value="101000983| 0 | 0" >BAL.IN DEPB W/OFF   MEPL</Option>

						<Option Value="101000086| 0 | 0" >BANK DIVIDEND   com</Option>

						<Option Value="101000089| 0 | 0" >BILL DISCOUNTING CHARGES RECEIVED   com</Option>

						<Option Value="101000093| 0 | 0" >BOOKS & PERIODICALS   com</Option>

						<Option Value="101000993| 0 | 0" >BOUGHTOUT ITEM FOR FORCE MOTORS -RAW MATERIAL   MEPL</Option>

						<Option Value="101000957| 0 | 0" >BOUGHTOUT ITEM FOR JCB -RAW MATERIAL   ME</Option>

						<Option Value="101001186| 0 | 0" >BOUGHTOUT ITEM FOR -TACO ASSEMBLY   MEPL</Option>

						<Option Value="101000975| 0 | 0" >BOX TRANSFER CHARGES   </Option>

						<Option Value="101000333| 0 | 0" >C.I.BOARING PURCHASE A/C   MFPL</Option>

						<Option Value="101000334| 0 | 0" >C.I.INNOCULIN PURCHASE A/C   MFPL</Option>

						<Option Value="101000335| 0 | 0" >C.I.SCRAP PURCHASE A/C   MFPL</Option>

						<Option Value="101000336| 0 | 0" >C.R.C. SCRAP PURCHASE  A/C   MFPL</Option>

						<Option Value="101000337| 0 | 0" >CAPATIVE CON R.C.SAND   MFPL</Option>

						<Option Value="101000338| 0 | 0" >CAPATIVE CONS.SHELL-MOULD   MFPL</Option>

						<Option Value="101000006|101140073|0" >CAPITAL EXPS. OTHER BUILDING. D-11 (WIP)   DI</Option>

						<Option Value="101000006|101140090|0" >CAR - FORCE ONE SX  MH-11-BH-4110   MEPL</Option>

						<Option Value="101000897| 0 | 0" >CAR EXPENSES (BEAT+INNOVA)   MEPL</Option>

						<Option Value="101000902| 0 | 0" >CAR EXPENSES (ELENTRA+INDICA)   </Option>

						<Option Value="101000006|101140003|0" >CAR INNOVA MH-11-Y-7629   MEPL</Option>

						<Option Value="101000905| 0 | 0" >CAR REPAIRS AND MAINTENANCE   </Option>

						<Option Value="101000814| 0 | 0" >CAR-CHEVROLET BEAT LTO TCDI   ME</Option>

						<Option Value="101000006|101140076|0" >CAR-CHEVROLET BEAT LTO TCDI   ME</Option>

						<Option Value="101000101| 0 | 0" >CASTING PURCHASE A/C   com</Option>

						<Option Value="101000006|101140084|0" >CENTRALISED COOLENT SYSTEM   MEPL</Option>

						<Option Value="101000339| 0 | 0" >CI NICKEL PURCHASE   MFPL</Option>

						<Option Value="101001163| 0 | 0" >CLAIM FOR NON DELIVERING OF MATERIAL   MEPL</Option>

						<Option Value="101001028| 0 | 0" >CLEANING CHARGES   MEPL</Option>

						<Option Value="101000924| 0 | 0" >CLEARING FORWARDING CHARGES   </Option>

						<Option Value="101001173| 0 | 0" >CMM INSPECTION CHARGES (INCOME)   MEPL</Option>

						<Option Value="101000955| 0 | 0" >COMPENSATION  OF GENERATON CLAIM   MEPL</Option>

						<Option Value="101000340| 0 | 0" >COMPENSATION RECD. FROM INSURANCE   MFPL</Option>

						<Option Value="101000006|101140004|0" >COMPUTER   COM</Option>

						<Option Value="101000102| 0 | 0" >COMPUTER REPAIRING & MAINT   com</Option>

						<Option Value="101000257| 0 | 0" >CONFERANCE EXPENSES   msipl</Option>

						<Option Value="101000995| 0 | 0" >CONSULTANCY CHARGES   </Option>

						<Option Value="101000104| 0 | 0" >CONSULTATION FEES-TECHNICAL   com</Option>

						<Option Value="101000105| 0 | 0" >CONSUMABLE PURCHASE   com</Option>

						<Option Value="101000411| 0 | 0" >CONSUMABLE STORES   DI </Option>

						<Option Value="101000412| 0 | 0" >CONSUMABLE TOOLS   DI </Option>

						<Option Value="101000341| 0 | 0" >COPPER SCRAP PURCHASE A/C   MFPL</Option>

						<Option Value="101000109| 0 | 0" >CORE MAKING CHARGES   com</Option>

						<Option Value="101000342| 0 | 0" >CPC PUR.   MFPL</Option>

						<Option Value="101001084| 0 | 0" >CST 14% NO C FORM   MFPL</Option>

						<Option Value="101000006|101140069|0" >DEAD STOCK   DI</Option>

						<Option Value="101000695| 0 | 0" >DEEMED EXPORT   COM</Option>

						<Option Value="101000111| 0 | 0" >DEEMED EXPORT SALES   com</Option>

						<Option Value="101000978| 0 | 0" >DEPB CREDIT (BAL.)   MEPL</Option>

						<Option Value="101000992| 0 | 0" >DEPB CREDIT A/C   MEPL</Option>

						<Option Value="101000344| 0 | 0" >DEPB LICANCE   MFPL</Option>

						<Option Value="101000474| 0 | 0" >DEPB LICENCE PROF.EXPS.   MEPL</Option>

						<Option Value="101000862| 0 | 0" >DEPB PURCHASE A/C   ME</Option>

						<Option Value="101000006|101140005|0" >DIES & FIXTURE   DI</Option>

						<Option Value="101000863| 0 | 0" >DIMINUTION IN VALUE OF SHARES   </Option>

						<Option Value="101000413| 0 | 0" >DISCOUNT RECEIVED ACCOUNT   DI </Option>

						<Option Value="101000959| 0 | 0" >DIVIDEND RECEIVED - KUB BANK LIMITED   DI</Option>

						<Option Value="101000691| 0 | 0" >DIVIDEND RECEIVED A/C   </Option>

						<Option Value="101000488| 0 | 0" >DOMESTIC PACKING   MEPL</Option>

						<Option Value="101000112| 0 | 0" >DONATION   com</Option>

						<Option Value="101000117| 0 | 0" >ELECTRIC INSPECTION FEES   com</Option>

						<Option Value="101001123| 0 | 0" >ELECTRICAL LINING EXPENSES   MFPL</Option>

						<Option Value="101000788| 0 | 0" >ELECTRICITY CHARGES   DI</Option>

						<Option Value="101001016| 0 | 0" >ELECTRICITY DUTY EXCEMPTION (H-21)   MEPL</Option>

						<Option Value="101001017| 0 | 0" >ELECTRICITY DUTY EXCEMPTION (H-25)   MEPL</Option>

						<Option Value="101000006|101140006|0" >ELECTRIFICATION   DI/MFPL</Option>

						<Option Value="101000006|101140081|0" >ELECTRIFICATION H-25   H21 WIP</Option>

						<Option Value="101000006|101140008|0" >ELECTRIFICATION U-1   MEPL</Option>

						<Option Value="101000006|101140009|0" >ELECTRIFICATION U-2   MEPL</Option>

						<Option Value="101000006|101140010|0" >ELECTRIFICATION WIP  (H-21)   MEPL</Option>

						<Option Value="101000006|101140011|0" >ELECTRIFICATION WIP (H-25)   MEPL</Option>

						<Option Value="101000006|101140064|0" >ERECTION  CHARGES   DI</Option>

						<Option Value="101000982| 0 | 0" >ERP SOFTWARE AMC CHARGES   ME</Option>

						<Option Value="101000689| 0 | 0" >ESCORT AND OCTROI EXPENSES   </Option>

						<Option Value="101000918| 0 | 0" >ESCORT/OCTORI REFUND A/C   ME</Option>

						<Option Value="101000119| 0 | 0" >E-TDS FILING FEE   com</Option>

						<Option Value="101000674| 0 | 0" >EX.DUTY ON SALES RET.(LAPSED)   COM</Option>

						<Option Value="101000675| 0 | 0" >EXCISE APPEAL FILING FEE   COM</Option>

						<Option Value="101001039| 0 | 0" >EXCISE DUTY LAPSED   </Option>

						<Option Value="101000907| 0 | 0" >EXCISE DUTY ON DRAWING & DESIGN   MEPL</Option>

						<Option Value="101000676| 0 | 0" >EXCISE DUTY PENALTY   COM</Option>

						<Option Value="101000906| 0 | 0" >EXCISE REFUND (DRAWING & DESIGN)   ME</Option>

						<Option Value="101000692| 0 | 0" >EXCISE REFUND ACCOUNT   </Option>

						<Option Value="101000122| 0 | 0" >EXHIBITION EXPENSES   com</Option>

						<Option Value="101000123| 0 | 0" >EXPORT- AIR FREIGHT   MEPL</Option>

						<Option Value="101000124| 0 | 0" >EXPORT EXPENSES (OTHERS)   MEPL</Option>

						<Option Value="101000041| 0 | 0" >EXPORT SALES   COM</Option>

						<Option Value="101000490| 0 | 0" >EXPORT-CARRIAGE INWARD   MEPL</Option>

						<Option Value="101000491| 0 | 0" >EXPORT-CONSUMABLES   MEPL</Option>

						<Option Value="101000492| 0 | 0" >EXPORT-ELECTROPLATING CHARGES   MEPL</Option>

						<Option Value="101000493| 0 | 0" >EXPORT-MACHINING CHARGES   MEPL</Option>

						<Option Value="101000496| 0 | 0" >EXPORT-PACKING   MEPL</Option>

						<Option Value="101000497| 0 | 0" >EXPORT-REJECTION & REWORK   MEPL</Option>

						<Option Value="101000498| 0 | 0" >EXPORT-TOOLING   MEPL</Option>

						<Option Value="101000499| 0 | 0" >EXPORT-TRANSPORT   MEPL</Option>

						<Option Value="101000415| 0 | 0" >FACOTRY INSURANCE   DI </Option>

						<Option Value="101000006|101140013|0" >FACTORY BUILDING - WIP (H-25)   MEPL</Option>

						<Option Value="101000006|101140078|0" >FACTORY BUILDING (CF)   DI</Option>

						<Option Value="101000006|101140082|0" >FACTORY BUILDING H-25   FB H-25</Option>

						<Option Value="101000006|101140094|0" >FACTORY BUILDING H-25 PART-II   UNIT-IV (WIP)   MEPL</Option>

						<Option Value="101000350| 0 | 0" >FACTORY BUILDING REPAIRS MAINT   MFPL</Option>

						<Option Value="101000006|101140014|0" >FACTORY BUILDING U-1   MEPL/MFPL</Option>

						<Option Value="101000006|101140015|0" >FACTORY BUILDING U-2   MEPL/MFPL</Option>

						<Option Value="101000006|101140086|0" >FACTORY EQUIPMENTS   </Option>

						<Option Value="101000125| 0 | 0" >FACTORY EXPENSES   com</Option>

						<Option Value="101000126| 0 | 0" >FACTORY INSPECTION FEES   com</Option>

						<Option Value="101000127| 0 | 0" >FACTORY LICENCE FEES   com</Option>

						<Option Value="101000352| 0 | 0" >FERRO CHROMIMUM PURCHASE A/C   MFPL</Option>

						<Option Value="101000353| 0 | 0" >FERRO MANGANSE PURCHASE A/C   MFPL</Option>

						<Option Value="101000354| 0 | 0" >FERRO MOLLY PURCHASE A\C   MFPL</Option>

						<Option Value="101000355| 0 | 0" >FERRO PHOSPORUS PURCHASE A/C   MFPL</Option>

						<Option Value="101000356| 0 | 0" >FERRO SILICON MANGANSE PURCHASES A/C   MFPL</Option>

						<Option Value="101000357| 0 | 0" >FERRO SILICON PURCHASE A/C   MFPL</Option>

						<Option Value="101000130| 0 | 0" >FESTIVAL EXPENSES   com</Option>

						<Option Value="101000131| 0 | 0" >FETTLING & PAINTING & GATE CUTTING & OTHER CHRGES   com</Option>

						<Option Value="101000971| 0 | 0" >FETTLING CHARGES   </Option>

						<Option Value="101000837| 0 | 0" >FINE   MFPL</Option>

						<Option Value="101000133| 0 | 0" >FINE RECOVERY A/C   com</Option>

						<Option Value="101000134| 0 | 0" >FOREIGN TOUR EXPENSES   com</Option>

						<Option Value="101000006|101140017|0" >FORKLIFT TRUCK   MEPL</Option>

						<Option Value="101000416| 0 | 0" >FOUNDRY EXPENSES   DI </Option>

						<Option Value="101000006|101140088|0" >FREEHOLD LAND-NAGEWADI TAL. & DIST.SATARA (GAT NO.291)   MEPL</Option>

						<Option Value="101000501| 0 | 0" >FREEHOLD PLOT NAIGAON KESURDI(INVESTMESNT)   MEPL</Option>

						<Option Value="101000006|101140019|0" >FREEHOLD PLOT-KESURDI NAIGAON(ASSET)   MEPL</Option>

						<Option Value="101001134| 0 | 0" >FURNACE HEAT CHARGES   MSIPL</Option>

						<Option Value="101000358| 0 | 0" >FURNACE LINING EXPENSES   MFPL</Option>

						<Option Value="101000006|101140068|0" >FURNITURE   DI</Option>

						<Option Value="101000006|101140074|0" >FURNITURE & DEAD STOCK H-25   MEPL</Option>

						<Option Value="101000006|101140021|0" >FURNITURE & DEAD STOCK U-1   MEPL</Option>

						<Option Value="101000006|101140022|0" >FURNITURE & DEAD STOCK U-2   MEPL</Option>

						<Option Value="101000135| 0 | 0" >GARDENING EXPENSES   com</Option>

						<Option Value="101000359| 0 | 0" >GAS PURCHASE (SAND-RECLAMATION)   MFPL</Option>

						<Option Value="101000006|101140023|0" >GATE AND WATCHMAN CABIN   MSIPL</Option>

						<Option Value="101000973| 0 | 0" >GATE CUTTING CHARGES   </Option>

						<Option Value="101000136| 0 | 0" >GENERAL REPAIRS & MAINT   com</Option>

						<Option Value="101000138| 0 | 0" >GIFTS & PRESENTATION   com</Option>

						<Option Value="101000913| 0 | 0" >GRAMPANCHAYAT TAX   MSIPL</Option>

						<Option Value="101000360| 0 | 0" >HARDNER PURCHASE A/C   MFPL</Option>

						<Option Value="101000858| 0 | 0" >HOLIDAY RESORT TIME SHARES DIMINISHED   MFPL</Option>

						<Option Value="101000268| 0 | 0" >HOUSEKEEPING  CHARGES   msipl</Option>

						<Option Value="101000508| 0 | 0" >INCOME TAX APPEAL FILING FEES   MEPL</Option>

						<Option Value="101000509| 0 | 0" >INCOME TAX FILING FEES   MEPL</Option>

						<Option Value="101001011| 0 | 0" >INCOME TAX REFUND (A.Y.2004-05)   ME</Option>

						<Option Value="101000418| 0 | 0" >INDUCTION FURNASE LINING CHARGES   DI </Option>

						<Option Value="101001096| 0 | 0" >INDUSTRIAL PROMOTION SUBSIDY (IPS) 2013-14   DI</Option>

						<Option Value="101001119| 0 | 0" >INDUSTRIAL PROMOTION SUBSIDY (IPS) 2014-15   MEPL</Option>

						<Option Value="101000939| 0 | 0" >INDUSTRIAL PROMOTION SUBSIDY (IPS) MEGA PROJECT  2011-12   MEPL</Option>

						<Option Value="101001026| 0 | 0" >INDUSTRIAL PROMOTION SUBSIDY (IPS) MEGA PROJECT  2012-13   MEPL</Option>

						<Option Value="101000936| 0 | 0" >INDUSTRIAL PROMOTION SUBSIDY-EXPANSION-PSI 2007-12   </Option>

						<Option Value="101000419| 0 | 0" >INSPECTION CHARGES   DI </Option>

						<Option Value="101000269| 0 | 0" >INSPECTION FEES TRANSFORMER   msipl</Option>

						<Option Value="101000151| 0 | 0" >INSURANCE   com</Option>

						<Option Value="101000988| 0 | 0" >INSURANCE  CLAIM RECEIVED   ME</Option>

						<Option Value="101001030| 0 | 0" >INSURANCE-WINDMILL   ME</Option>

						<Option Value="101000954| 0 | 0" >INTEREST ON AXIS BANK FD   DI</Option>

						<Option Value="101001068| 0 | 0" >INTEREST ON FD SARASWAT CO-OP.BANK LTD. A/C NO.370   U-III</Option>

						<Option Value="101000524| 0 | 0" >INTEREST ON INCOME TAX REFUND   MEPL</Option>

						<Option Value="101000801| 0 | 0" >INTEREST ON RATE DIFFERENCE INVOICES   MSIPL</Option>

						<Option Value="101000877| 0 | 0" >INTEREST RECEIVED ON ADVANCES   </Option>

						<Option Value="101001138| 0 | 0" >INTEREST RECEIVED ON INVESTMENT   ME</Option>

						<Option Value="101000871| 0 | 0" >INTEREST RECEIVED ON MSEB DEPOSIT   DI</Option>

						<Option Value="101001124| 0 | 0" >INTEREST RECEIVED ON RECURING DEPOSIT   MFPL</Option>

						<Option Value="101001155| 0 | 0" >INTEREST RECEIVED ON ROHA MEGACITY DEVELOPERS LLP   </Option>

						<Option Value="101001108| 0 | 0" >INTEREST RECEIVED ON WATER DEPOSIT (MIDC)   MFPL</Option>

						<Option Value="101000994| 0 | 0" >INVESTMENT W/OFF A/C   </Option>

						<Option Value="101000154| 0 | 0" >ISO / TS / TPM / UNIDO EXPENSES   com</Option>

						<Option Value="101000006|101140024|0" >JIG DIES & FIXTURE U-1   MEPL</Option>

						<Option Value="101000006|101140025|0" >JIG DIES & FIXTURE U-2   MEPL</Option>

						<Option Value="101000301| 0 | 0" >JOB WORK CHARGES   msipl</Option>

						<Option Value="101000373| 0 | 0" >KEY MAN INSURANCE PREMIMUM   MFPL</Option>

						<Option Value="101000972| 0 | 0" >KNOCKOUT CHARGES   </Option>

						<Option Value="101000006|101140063|0" >LABORATORY EQUIPMENT   MSIPL</Option>

						<Option Value="101000374| 0 | 0" >LABORATORY EXPENSES   MFPL</Option>

						<Option Value="101000709| 0 | 0" >LABOUR CHARGES A/C   </Option>

						<Option Value="101000044| 0 | 0" >LABOUR PURCHASE ACCOUNT   COM</Option>

						<Option Value="101000038| 0 | 0" >LABOUR SALES ACCOUNT   COM</Option>

						<Option Value="101000006|101140077|0" >LAND (CF)   DI</Option>

						<Option Value="101000006|101140067|0" >LAND (LEASEHOLD)   MFPL</Option>

						<Option Value="101000006|101140085|0" >LAND (WINDMILL)   MEPL</Option>

						<Option Value="101000899| 0 | 0" >LATE DELIVERY EXTRA CHARGES   </Option>

						<Option Value="101000859| 0 | 0" >LEASE FOR EXPIRED PERIOD OF MIDC LAND   MFPL</Option>

						<Option Value="101000006|101140028|0" >LEASEHOLD LAND (PLOT NO.H-21)   MEPL</Option>

						<Option Value="101000006|101140093|0" >LEASEHOLD LAND (PLOT NO.H-25) PART-II   H25</Option>

						<Option Value="101000162| 0 | 0" >LEGAL EXPENSES   com</Option>

						<Option Value="101001136| 0 | 0" >LICENCE - FOCUS PRODUCT SCHEME   MEPL</Option>

						<Option Value="101001185| 0 | 0" >LICENCE - MERCHANDISE EXPORTS OF INDIA SCHEME (MEIS)   MEPL</Option>

						<Option Value="101000303| 0 | 0" >LICENCES RENEWAL FEES   msipl</Option>

						<Option Value="101000941| 0 | 0" >LICENSE (STATUS HOLDER INCENTIVE SCRIP)   MEPL</Option>

						<Option Value="101001079| 0 | 0" >LINER CUTTING CHARGES   MSIPL</Option>

						<Option Value="101000961| 0 | 0" >LOADING & UNLOADING CHARGES   ALL</Option>

						<Option Value="101001025| 0 | 0" >LOCAL BODY TAX (LBT)   MEPL</Option>

						<Option Value="101000164| 0 | 0" >LOCAL CONVEYANCE   com</Option>

						<Option Value="101001003| 0 | 0" >LOSS ON MOULDING BOXES SCRAP   DI</Option>

						<Option Value="101001160| 0 | 0" >LOSS ON SALE OF  PLANT & MACHINERY   MEPL</Option>

						<Option Value="101001002| 0 | 0" >LOSS ON SALE OF CAR   DI</Option>

						<Option Value="101000977| 0 | 0" >LOSS ON SALE OF DEPB LICENCE   MEPL</Option>

						<Option Value="101000590| 0 | 0" >LOSS ON SALE OF DSP BLACKROCK MUTUAL FUND   MEPL</Option>

						<Option Value="101001037| 0 | 0" >LOSS ON SALE OF SHARES/CONVERSION OF SHARES   MEPL</Option>

						<Option Value="101000378| 0 | 0" >M.S.ROUND BAR   MFPL</Option>

						<Option Value="101000379| 0 | 0" >M.S.SCRAP PURCHASE A/C   MFPL</Option>

						<Option Value="101000591| 0 | 0" >MACHINE SHOP EXPENSES   MEPL</Option>

						<Option Value="101000592| 0 | 0" >MACHINERY RENT PAID   MEPL</Option>

						<Option Value="101000710| 0 | 0" >MACHINING CHARGES   </Option>

						<Option Value="101000165| 0 | 0" >MACHINING/LABOUR CHARGES   com</Option>

						<Option Value="101000781| 0 | 0" >MANUFACTURING SALES RETURN   </Option>

						<Option Value="101000935| 0 | 0" >MANUFACTURING SALES RETURN SHELL MOULD   </Option>

						<Option Value="101000782| 0 | 0" >MANUFACTURING SALES RETURN-OMS   </Option>

						<Option Value="101000841| 0 | 0" >MAX NEWYORK LIFE PARTNER INSURANCE PREMIUM   MEPL</Option>

						<Option Value="101000380| 0 | 0" >MEMBERSHIP FEES A/C   MFPL</Option>

						<Option Value="101000595| 0 | 0" >MIDC EXPENSES   MEPL</Option>

						<Option Value="101001149| 0 | 0" >MIDC NAME CHANGE CHARGES   MSIPL</Option>

						<Option Value="101000167| 0 | 0" >MISC.INCOME   com</Option>

						<Option Value="101000168| 0 | 0" >MISCELLENIOUS EXPENSES.   com</Option>

						<Option Value="101000169| 0 | 0" >MOBILE EXPENSES   com</Option>

						<Option Value="101000306| 0 | 0" >MONITORING AGENCY FEES   msipl</Option>

						<Option Value="101000945| 0 | 0" >MONO RAIL C WIP W/OFF   MSIPL</Option>

						<Option Value="101000381| 0 | 0" >MOULDING CHARGES   MFPL</Option>

						<Option Value="101000307| 0 | 0" >MPC BOARD REGD. CHARGES   msipl</Option>

						<Option Value="101000384| 0 | 0" >NOTICE PAY A/C   COM</Option>

						<Option Value="101000006|101140033|0" >OFFICE BUILDING (PUNE FLAT)   MEPL</Option>

						<Option Value="101000006|101140034|0" >OFFICE BUILDING U-1   MEPL/MFPL</Option>

						<Option Value="101000006|101140035|0" >OFFICE BUILDING U-2   MEPL/MFPL</Option>

						<Option Value="101000006|101140036|0" >OFFICE EQUIPMENT   MEPL/MFPL</Option>

						<Option Value="101000172| 0 | 0" >OFFICE EXPENSES   com</Option>

						<Option Value="101000173| 0 | 0" >OFFICE -RENT   com</Option>

						<Option Value="101000962| 0 | 0" >OFFICERS CLUB EXPENSES   </Option>

						<Option Value="101000934| 0 | 0" >ONE MONTH NOTICE PAYMENT   ME</Option>

						<Option Value="101000385| 0 | 0" >OTHER RAW MATERIAL   MFPL</Option>

						<Option Value="101000310| 0 | 0" >P.F DAMAGES 09.10   msipl</Option>

						<Option Value="101000311| 0 | 0" >P.F. DAMAGES 08.09   msipl</Option>

						<Option Value="101000784| 0 | 0" >PACKING & FORWARDING-SALES   </Option>

						<Option Value="101000696| 0 | 0" >PACKING & FORWARIDNG PURCHASE   </Option>

						<Option Value="101000974| 0 | 0" >PAINTING CHARGES   </Option>

						<Option Value="101000849| 0 | 0" >PARTNERS REMUNERATION   </Option>

						<Option Value="101000006|101140037|0" >PATTERN   DI</Option>

						<Option Value="101000006|101140038|0" >PATTERN - JIG & DIES   MSIPL</Option>

						<Option Value="101000398| 0 | 0" >PATTERN MAINTAINCES CHARGES   COM</Option>

						<Option Value="101000772| 0 | 0" >PATTERN REPAIRS   MFPL</Option>

						<Option Value="101000937| 0 | 0" >PENALTY ON SERVICE TAX   ME</Option>

						<Option Value="101000844| 0 | 0" >PENALTY ON VAT TAX   </Option>

						<Option Value="101000312| 0 | 0" >PF DAMAGES RECOVERED   msipl</Option>

						<Option Value="101000183| 0 | 0" >PIG IRON   com</Option>

						<Option Value="101000006|101140039|0" >PLANT & MACHINERY   DI/MSIPL</Option>

						<Option Value="101000006|101140040|0" >PLANT & MACHINERY  (WIP)   DI</Option>

						<Option Value="101000006|101140072|0" >PLANT & MACHINERY (H-25) WIP   MEPL</Option>

						<Option Value="101000006|101140055|0" >PLANT & MACHINERY (WEIGHBRIDGE)   MFPL</Option>

						<Option Value="101000006|101140092|0" >PLANT & MACHINERY ERRECTION   DI</Option>

						<Option Value="101000006|101140079|0" >PLANT & MACHINERY H-25   H-21</Option>

						<Option Value="101000006|101140041|0" >PLANT & MACHINERY U-1   MEPL/MFPL</Option>

						<Option Value="101000006|101140042|0" >PLANT & MACHINERY U-2   MEPL/MFPL</Option>

						<Option Value="101000006|101140043|0" >PLANT & MACHINERY U-3   MEPL</Option>

						<Option Value="101000184| 0 | 0" >POLUTION CONTROL FEES   com</Option>

						<Option Value="101000185| 0 | 0" >POSTAGE & COURIER CHARGES   com</Option>

						<Option Value="101000603| 0 | 0" >POWDER COATING CHARGES(DOMESTIC)   MEPL</Option>

						<Option Value="101000604| 0 | 0" >POWDER COATING CHARGES(EXPORT)   MEPL</Option>

						<Option Value="101000006|101140095|0" >POWDER COATING WIP   U-III</Option>

						<Option Value="101001222| 0 | 0" >POWER & ELECTRICITY CHARGES - POWDER COATING PLANT   MFPL</Option>

						<Option Value="101000874| 0 | 0" >POWER & ELECTRICITY CHARGES (H-25)   ME H25</Option>

						<Option Value="101000186| 0 | 0" >POWER & ELECTRICITY EXPENSES   com</Option>

						<Option Value="101001140| 0 | 0" >POWER CONSULTANCY CHARGES   DI/MFPL</Option>

						<Option Value="101000188| 0 | 0" >PRINTING & STATIONERY   com</Option>

						<Option Value="101000976| 0 | 0" >PRIOR YEAR ADJUSTMENT CST 2%   </Option>

						<Option Value="101001051| 0 | 0" >PRIOR YEAR MOBILE EXPENSES   MSIPL</Option>

						<Option Value="101000192| 0 | 0" >PROFESSION TAX (COMPANY)   com</Option>

						<Option Value="101000194| 0 | 0" >PROFESSIONAL CHARGES   com</Option>

						<Option Value="101000609| 0 | 0" >PROFIT ON SALE OF  FREEHOLD LAND-KHINDWADI   MEPL</Option>

						<Option Value="101000779| 0 | 0" >PROFIT ON SALE OF DEPB LICENCE   MEPL</Option>

						<Option Value="101001152| 0 | 0" >PROFIT ON SALE OF FIXTURE   MEPL</Option>

						<Option Value="101001194| 0 | 0" >PROFIT ON SALE OF INNOVA CAR (MH-11-Y-7629)   MEPL</Option>

						<Option Value="101000195| 0 | 0" >PROFIT ON SALE OF MACHINERY   com</Option>

						<Option Value="101000196| 0 | 0" >PROFIT ON SALE OF RELIANCE GROWTH FUND (D)   com</Option>

						<Option Value="101000884| 0 | 0" >PROFIT ON SALE OF SCRAP CAR MH-18 B - 875   </Option>

						<Option Value="101000197| 0 | 0" >PROFIT ON SALE OF SHARES   com</Option>

						<Option Value="101000930| 0 | 0" >PROFIT/LOSS ON SALE OF SHARES   ME</Option>

						<Option Value="101000866| 0 | 0" >PROVISION FOR RATE AMENDMENT   </Option>

						<Option Value="101001174| 0 | 0" >PROVISION FOR RATE REDUCTION   </Option>

						<Option Value="101000433| 0 | 0" >PUR S.G CRC SCRAP   DI </Option>

						<Option Value="101000434| 0 | 0" >PUR. C.I.SCRAP   DI </Option>

						<Option Value="101000435| 0 | 0" >PUR.ALUMINIUM SCRAP   DI </Option>

						<Option Value="101000436| 0 | 0" >PUR.C.I.BOARING   DI </Option>

						<Option Value="101000437| 0 | 0" >PUR.C.I.CASTINGS   DI </Option>

						<Option Value="101000438| 0 | 0" >PUR.COKE   DI </Option>

						<Option Value="101000611| 0 | 0" >PUR.CONS.STORES   MEPL</Option>

						<Option Value="101000612| 0 | 0" >PUR.CONS.TOOLS   MEPL</Option>

						<Option Value="101000439| 0 | 0" >PUR.M.S.SCRAP   DI </Option>

						<Option Value="101000440| 0 | 0" >PUR.OTHER RAW MATERIAL   DI </Option>

						<Option Value="101000441| 0 | 0" >PUR.PIG IRON   DI </Option>

						<Option Value="101000442| 0 | 0" >PUR:-M.S.ROUND BAR   DI </Option>

						<Option Value="101000613| 0 | 0" >PURCHASE (CI+SGI) CASTINGS   MEPL</Option>

						<Option Value="101000614| 0 | 0" >PURCHASE CI SCRAP   MEPL</Option>

						<Option Value="101001000| 0 | 0" >PURCHASE CI/SGI CASTINGS H-25   H25</Option>

						<Option Value="101000615| 0 | 0" >PURCHASE EXPORT CASTING (SGI+CI)   MEPL</Option>

						<Option Value="101000723| 0 | 0" >PURCHASE OF ALUMN.CASTINGS (DOM+EXPORT)   </Option>

						<Option Value="101000387| 0 | 0" >PURCHASE OF CONSUMABLE STORES   MFPL</Option>

						<Option Value="101001081| 0 | 0" >PURCHASE RETURN   </Option>

						<Option Value="101000764| 0 | 0" >PURCHASE RETURN - ALUMN.CASTINGS -DOMESTIC    MEPL</Option>

						<Option Value="101001001| 0 | 0" >PURCHASE RETURN - CI/SGI CASTINGS H-25    H25</Option>

						<Option Value="101000762| 0 | 0" >PURCHASE RETURN - CI/SGI CASTINGS-DOMESTIC    MEPL</Option>

						<Option Value="101000763| 0 | 0" >PURCHASE RETURN - S.G.I CASTINGS-EXPORT    MEPL</Option>

						<Option Value="101000688| 0 | 0" >PURCHASE S G I CASTING   MSIPL</Option>

						<Option Value="101000616| 0 | 0" >PURCHASE SGI SCRAP   MEPL</Option>

						<Option Value="101000443| 0 | 0" >PURCHASE SHELL MOULD (CORE MAKING)   DI </Option>

						<Option Value="101001099| 0 | 0" >PURCHASE TIN INGOT   DI</Option>

						<Option Value="101000444| 0 | 0" >PURCHASE-C.P.COKE   DI </Option>

						<Option Value="101000314| 0 | 0" >QUALITY CONTROL EXPS   msipl</Option>

						<Option Value="101000315| 0 | 0" >R.M. (OTHER)   msipl</Option>

						<Option Value="101000205| 0 | 0" >R.O.C. EXPENSES   com</Option>

						<Option Value="101000915| 0 | 0" >RATE DIFFERANCE   </Option>

						<Option Value="101000970| 0 | 0" >RATE DIFFERANCE OMS   </Option>

						<Option Value="101000316| 0 | 0" >RAW MATERIAL PURCHASE   msipl</Option>

						<Option Value="101000388| 0 | 0" >RAW SILICA SAND PURCHASE A/C   MFPL</Option>

						<Option Value="101000943| 0 | 0" >RAW SILICA SAND RECLAIMED PURCHASE   </Option>

						<Option Value="101001007| 0 | 0" >REC TRADE  INCOME (INDIAN ENERGY EXCHANGE)   ME</Option>

						<Option Value="101001008| 0 | 0" >REC TRADE EXPENSES   ME</Option>

						<Option Value="101000914| 0 | 0" >REJECTION CHARGES   </Option>

						<Option Value="101000445| 0 | 0" >REJECTION INWORD EXPENSES   DI </Option>

						<Option Value="101000207| 0 | 0" >RENT ,RATES &TAXES   com</Option>

						<Option Value="101001220| 0 | 0" >RENT FOR POWDER COATING PLANT   MFPL</Option>

						<Option Value="101000318| 0 | 0" >RENT TO MUTHA ENGINEERING   msipl</Option>

						<Option Value="101000622| 0 | 0" >RENTING OF IMMOVIABLE PROPERTY-CORP.OFFICE   MEPL</Option>

						<Option Value="101000045| 0 | 0" >REPAIR SALES ACCOUNT   COM</Option>

						<Option Value="101000208| 0 | 0" >REPAIRS & MAINTAINANCE-GENERAL   com</Option>

						<Option Value="101000209| 0 | 0" >REPAIRS & MAINTAINANCE-MACHINERY   com</Option>

						<Option Value="101000389| 0 | 0" >RESIN COATED SAND PURCHASE A/C   MFPL</Option>

						<Option Value="101000390| 0 | 0" >RESIN LIQUID PURCHASE A/C   MFPL</Option>

						<Option Value="101000211| 0 | 0" >RETAINERSHIP CHARGES   com</Option>

						<Option Value="101001013| 0 | 0" >REWORK CHARGES - DOMESTIC   ME</Option>

						<Option Value="101000212| 0 | 0" >ROC FILING FEES   com</Option>

						<Option Value="101000009| 0 | 0" >ROUNDING OFF ACCOUNT   erp a/c</Option>

						<Option Value="101000780| 0 | 0" >SALE ALUMINIUM  BORING   MEPL</Option>

						<Option Value="101001040| 0 | 0" >SALE ALUMINIUM  SCRAP   MEPL</Option>

						<Option Value="101000767| 0 | 0" >SALE ALUMN..MACH.CASTINGS -SALES RETURN   MEPL</Option>

						<Option Value="101000786| 0 | 0" >SALE ALUMN.CASTING OMS 2%   DI</Option>

						<Option Value="101000624| 0 | 0" >SALE C.I.BOARING   MEPL</Option>

						<Option Value="101000948| 0 | 0" >SALE C.I.BOARING SALES RETURN   ME</Option>

						<Option Value="101000785| 0 | 0" >SALE C.I.CASTINGS OMS 2%   DI</Option>

						<Option Value="101000776| 0 | 0" >SALE C.I.MACH.CASTINGS -OMS 2%   MEPL</Option>

						<Option Value="101000766| 0 | 0" >SALE C.I.MACH.CASTINGS -SALES RETURN   MEPL</Option>

						<Option Value="101001207| 0 | 0" >SALE CASTINGS EXPORT  (U-III)   MSIPL</Option>

						<Option Value="101000998| 0 | 0" >SALE CI/SGI CASTINGS    H-25   H25</Option>

						<Option Value="101000999| 0 | 0" >SALE CI/SGI CASTINGS - SALES RETURN H-25   H25</Option>

						<Option Value="101000996| 0 | 0" >SALE CI/SGI MACHINED CASTING  H-25   H25</Option>

						<Option Value="101000997| 0 | 0" >SALE CI/SGI MACHINED CASTING - SALE RETURN  H25   H25</Option>

						<Option Value="101000789| 0 | 0" >SALE- CORES & MOULD   </Option>

						<Option Value="101000951| 0 | 0" >SALE MACH.CASTINGS EXPORT-SALE RETURN   ME</Option>

						<Option Value="101000777| 0 | 0" >SALE MACH.CASTINGS -OMS2% SALES RETURN   MEPL</Option>

						<Option Value="101001070| 0 | 0" >SALE MACHINING DEFECTIVES- REJECTION   MEPL</Option>

						<Option Value="101000950| 0 | 0" >SALE MACHINING/LABOUR CHARGES SALE RETURN   ME</Option>

						<Option Value="101000797| 0 | 0" >SALE MOULDING BOX   DI</Option>

						<Option Value="101000625| 0 | 0" >SALE OF DEPB LICENCE   MEPL</Option>

						<Option Value="101000980| 0 | 0" >SALE OF WIND POWER ELECTRICITY   MEPL</Option>

						<Option Value="101000790| 0 | 0" >SALE OTHER   DI</Option>

						<Option Value="101000833| 0 | 0" >SALE PIG IRON   DI</Option>

						<Option Value="101000765| 0 | 0" >SALE PURCHASE (REJ.) ALUMN.CASTINGS -EXPORT   MEPL</Option>

						<Option Value="101001075| 0 | 0" >SALE RATE REDUCTION ALUMN.CASTINGS   DI</Option>

						<Option Value="101001074| 0 | 0" >SALE RATE REDUCTION C.I.CASTINGS   DI</Option>

						<Option Value="101000931| 0 | 0" >SALE RATE REDUCTION -DOMESTIC   MEPL</Option>

						<Option Value="101001209| 0 | 0" >SALE RATE REDUCTION -DOMESTIC H-25   MEPL II</Option>

						<Option Value="101000933| 0 | 0" >SALE RATE REDUCTION -EXPORT   MEPL</Option>

						<Option Value="101000932| 0 | 0" >SALE RATE REDUCTION OMS 2%   ME</Option>

						<Option Value="101000944| 0 | 0" >SALE RAW SILICA SAND RECLAIMED   </Option>

						<Option Value="101000949| 0 | 0" >SALE S.G.I.BOARING SALE RETURN   MEPL</Option>

						<Option Value="101000829| 0 | 0" >SALE TAX DUES   DI</Option>

						<Option Value="101000629| 0 | 0" >SALE-AIR FREIGHT-(INCOME)   MEPL</Option>

						<Option Value="101000630| 0 | 0" >SALE-MACHINED CASTINGS-DOMESTIC   MEPL</Option>

						<Option Value="101000631| 0 | 0" >SALE-MACHINED CASTINGS-EXPORT   MEPL</Option>

						<Option Value="101000773| 0 | 0" >SALE-MACHINING/LABOUR CHARGES   </Option>

						<Option Value="101000632| 0 | 0" >SALE-PLANT &MACHINERY U3   MEPL</Option>

						<Option Value="101000392| 0 | 0" >SALES - EXPORT   MFPL</Option>

						<Option Value="101001184| 0 | 0" >SALES  TAX APPEAL FILING FEES   MEPL</Option>

						<Option Value="101000633| 0 | 0" >SALES - TOOL COST   MEPL</Option>

						<Option Value="101001218| 0 | 0" >SALES - TOOLS COST EXPORT   MEPL</Option>

						<Option Value="101000447| 0 | 0" >SALES ALUMN.CASTINGS   DI </Option>

						<Option Value="101001172| 0 | 0" >SALES ALUMN.CASTINGS - SALES RETURN   DI</Option>

						<Option Value="101000774| 0 | 0" >SALES ALUMN.CASTINGS (DOMESTIC)   </Option>

						<Option Value="101000775| 0 | 0" >SALES ALUMN.CASTINGS (EXPORT)   </Option>

						<Option Value="101001082| 0 | 0" >SALES ALUMN.CASTINGS (OMS 2%)   ME</Option>

						<Option Value="101001083| 0 | 0" >SALES ALUMN.CASTINGS (OMS 2%) SALES RETURN   ME</Option>

						<Option Value="101000448| 0 | 0" >SALES C.I.CASTINGS   COM</Option>

						<Option Value="101001170| 0 | 0" >SALES C.I.CASTINGS - SALES RETURN   DI</Option>

						<Option Value="101001171| 0 | 0" >SALES C.I.CASTINGS OMS 2% - SALES RETURN   DI</Option>

						<Option Value="101000634| 0 | 0" >SALES C.I.SCRAP   MEPL</Option>

						<Option Value="101001085| 0 | 0" >SALES CAS 4   </Option>

						<Option Value="101000783| 0 | 0" >SALES CASTING -OMS   </Option>

						<Option Value="101001010| 0 | 0" >SALES COMPUTER   </Option>

						<Option Value="101000891| 0 | 0" >SALES CONSUMABLE MATERIAL   MSIPL</Option>

						<Option Value="101000865| 0 | 0" >SALES CREDIT NOTE ACCOUNTS ONLY   MSIPL</Option>

						<Option Value="101001169| 0 | 0" >SALES CREDIT NOTE ACCOUNTS ONLY - OMS   MSIPL</Option>

						<Option Value="101000460| 0 | 0" >SALES OF DEPB LICENCE   MEPL/DI</Option>

						<Option Value="101000451| 0 | 0" >SALES- PLANT & MACHINERY   DI </Option>

						<Option Value="101000637| 0 | 0" >SALES PROMOTION   COM</Option>

						<Option Value="101000394| 0 | 0" >SALES R.C. SAND   MFPL</Option>

						<Option Value="101000890| 0 | 0" >SALES RAW MATERIAL   MSIPL</Option>

						<Option Value="101000319| 0 | 0" >SALES S. G. IRON CASTINGS   COM</Option>

						<Option Value="101000864| 0 | 0" >SALES S. G. IRON CASTINGS- OMS   MSIPL</Option>

						<Option Value="101000638| 0 | 0" >SALES S.G.I. SCRAP   MEPL</Option>

						<Option Value="101000639| 0 | 0" >SALES S.G.I.BOARING   MEPL</Option>

						<Option Value="101000395| 0 | 0" >SALES SHELL MOULD   MFPL</Option>

						<Option Value="101001077| 0 | 0" >SALES TAX REFUND 2005-06   MEPL</Option>

						<Option Value="101000456| 0 | 0" >SALES-C. I. BOARING   DI </Option>

						<Option Value="101000641| 0 | 0" >SALES-MACHINING CHARGES   MEPL</Option>

						<Option Value="101000642| 0 | 0" >SALES-TOOL/DRILL/TAPS (SCRAP)   MEPL</Option>

						<Option Value="101001071| 0 | 0" >SALES-TOOLS & EQUIPMENTS   MFPL</Option>

						<Option Value="101000947| 0 | 0" >SCHEDULE ADHELS PENALTY   ME</Option>

						<Option Value="101000822| 0 | 0" >SCHEME OF DUTY DRAWBACK RECEIPT   MEPL</Option>

						<Option Value="101000039| 0 | 0" >SCRAP SALES   COM</Option>

						<Option Value="101000215| 0 | 0" >SECURITY EXPENSES   com</Option>

						<Option Value="101000938| 0 | 0" >SEGREGATION & REWORK CHARGES   </Option>

						<Option Value="101000216| 0 | 0" >SEMINAR & CONFERANCE CHARGES   com</Option>

						<Option Value="101000321| 0 | 0" >SHOTBLASTING EXPS   msipl</Option>

						<Option Value="101001120| 0 | 0" >SOCIAL WELFARE EXPENSES   MFPL</Option>

						<Option Value="101001052| 0 | 0" >SOFTWARE EXPENSES   MEPL</Option>

						<Option Value="101000322| 0 | 0" >SPECTRO TESTING  CHARGES   msipl</Option>

						<Option Value="101001135| 0 | 0" >SPILLAGE COLLECTION CHARGES   MSIPL</Option>

						<Option Value="101000896| 0 | 0" >SPONSORSHIP CHARGES   </Option>

						<Option Value="101000221| 0 | 0" >SUBSCRIPTION   com</Option>

						<Option Value="101000873| 0 | 0" >SUNDRY CREDITORS W/OFF ACCOUNT   MFPL</Option>

						<Option Value="101001100| 0 | 0" >SUNDRY DEBTORS SETTLEMENT ACCOUNT   MEPL </Option>

						<Option Value="101001101| 0 | 0" >SUNDRY DEBTORS SETTLMENT A/C   MEPL</Option>

						<Option Value="101000651| 0 | 0" >SUNDRY DRS. WRITTEN/OFF   MEPL</Option>

						<Option Value="101001129| 0 | 0" >SWACHH BAHART CESS   MEPL</Option>

						<Option Value="101000800| 0 | 0" >T.S.PROGRAM EXPENSES   </Option>

						<Option Value="101000238| 0 | 0" >TEA & HOTEL EXP (GUEST)   com</Option>

						<Option Value="101000241| 0 | 0" >TELEPHONE CHARGES   com</Option>

						<Option Value="101000403| 0 | 0" >TIN PURCHASE A/C   MFPL</Option>

						<Option Value="101000006|101140066|0" >TOOLS & EQUIPMENT   MFPL</Option>

						<Option Value="101000006|101140045|0" >TOOLS & EQUIPMENT U-1   MEPL</Option>

						<Option Value="101000006|101140046|0" >TOOLS & EQUIPMENT U-2   MEPL</Option>

						<Option Value="101000989| 0 | 0" >TOOLS GRINDING/RESHARPNING CHARGES-DOMESTIC   ME</Option>

						<Option Value="101000990| 0 | 0" >TOOLS GRINDING/RESHARPNING CHARGES-EXPORT   ME</Option>

						<Option Value="101000657| 0 | 0" >TPM MEMBERSHIP FEES   MEPL</Option>

						<Option Value="101000006|101140080|0" >TRACTOR TRAILOR RED (TROLLEY)   MEPL</Option>

						<Option Value="101000099| 0 | 0" >TRANSPORT  CHARGES (INWARD)   com</Option>

						<Option Value="101000242| 0 | 0" >TRANSPORT CHARGES (OUTWARD)   com</Option>

						<Option Value="101000461| 0 | 0" >TRANSPORT CHARGES (SALES)   DI </Option>

						<Option Value="101000243| 0 | 0" >TRANSPORT CHARGES LOCAL   com</Option>

						<Option Value="101000658| 0 | 0" >TRAVELLING EXPENSES   COM</Option>

						<Option Value="101000006|101140047|0" >TYPE WRITER   MEPL</Option>

						<Option Value="101000981| 0 | 0" >VALUE OF UNITS GENERATED-WTG   MEPL</Option>

						<Option Value="101001012| 0 | 0" >VANEDIUM PURCHASE   </Option>

						<Option Value="101000663| 0 | 0" >VAT REDUCTION 2%   MEPL</Option>

						<Option Value="101001131| 0 | 0" >VAT REFUND 2010-11   DI</Option>

						<Option Value="101000960| 0 | 0" >VAT TAX APPEAL FEE   MEPL</Option>

						<Option Value="101000842| 0 | 0" >VAT TAX DUES   </Option>

						<Option Value="101000006|101140091|0" >VEHICLE - FORD ECO SPORTS   DI</Option>

						<Option Value="101000006|101140097|0" >VEHICLE - INNOVA CRYSTA MH-11-BV-7022   DI</Option>

						<Option Value="101000248| 0 | 0" >VEHICLE REPAIRS & MAINT   com</Option>

						<Option Value="101000667| 0 | 0" >VENDOR MACHINE SHOP EXPS.   MEPL</Option>

						<Option Value="101000669| 0 | 0" >WARRANTY CLAIM   MEPL</Option>

						<Option Value="101000251| 0 | 0" >WATER CHARGES   com</Option>

						<Option Value="101001221| 0 | 0" >WATER CHARGES - POWDER COATING PLANT   MFPL</Option>

						<Option Value="101000875| 0 | 0" >WATER CHARGES (H-25)   MEPL</Option>

						<Option Value="101000465| 0 | 0" >WATER PLOUTION   DI </Option>

						<Option Value="101000253| 0 | 0" >WEIGHMENT CHARGES   com</Option>

						<Option Value="101000929| 0 | 0" >WIND ENERGY CHARGES RECEIVED FROM MSEDCL   MEPL</Option>

						<Option Value="101000006|101140083|0" >WINDMILL   MEPL</Option>

						<Option Value="101000880| 0 | 0" >WINDMILL EXPENSES   MEPL</Option>

						<Option Value="101000006|101140089|0" >WIP LINER PROJECT   </Option>

						<Option Value="101000006|101140096|0" >WIP PLANT & MACHINERY (POWDER COATING PLANT)   MFPL</Option>

						<Option Value="101000006|101140075|0" >WIP PLANT AND MACHINARY   MSIPL</Option>

						<Option Value="101000006|101140065|0" >WIP VINAR & PAINT SHOP PROJECT   MFPL</Option>

						<Option Value="101001143| 0 | 0" >WMDC DUES   DI</Option>

						<Option Value="101000006|101140070|0" >WORKS EQUIPMENTS   DI</Option>

						<Option Value="101000815| 0 | 0" >XEROX MACHINE RENT PAID   ME</Option>

				</select>
			</td>
		</tr>
		<tr>
			<td width="05%" colspan="05" align="left"> &nbsp</td>
			<td Width="25%" colspan="25" align="left">
				<label class="caption" >Purchase Return</label>
			</td>
			<Td Width="70%" colspan="70" align="left">
				<Select id="drpPurhRetAcNo" name="drpPurhRetAcNo"  TabIndex="28" >
					<Option Value="0">&nbsp;</Option>
					
						<Option Value="101001032| 0 | 0" >ACMA CLUSTER EXPENSES   MFPL</Option>

						<Option Value="101001023| 0 | 0" >ADVANCE LAPS (SALARY)   MFPL</Option>

						<Option Value="101001125| 0 | 0" >ADVANCE W/OFF - (DWARKADAS SHAMKUMAR TEXTILES PVT.LTD.   MFPL</Option>

						<Option Value="101000082| 0 | 0" >ADVERTISEMENT & PUBLICITY   com</Option>

						<Option Value="101000901| 0 | 0" >ADVOCATE FEES   </Option>

						<Option Value="101000255| 0 | 0" >ANNEALING  CHARGES   msipl</Option>

						<Option Value="101000040| 0 | 0" >APPRICIATION VALUE OF SHARE   MEPL</Option>

						<Option Value="101000330| 0 | 0" >ASSEMENT DUES (GOVT. AGENCIES)   MFPL</Option>

						<Option Value="101000761| 0 | 0" >AUDIT FEES   MSIPL</Option>

						<Option Value="101000006|101140071|0" >AUTO TRUCK TRIALOR   DI</Option>

						<Option Value="101000084| 0 | 0" >BAD & DOUBTFUL DEBTS   com</Option>

						<Option Value="101000983| 0 | 0" >BAL.IN DEPB W/OFF   MEPL</Option>

						<Option Value="101000086| 0 | 0" >BANK DIVIDEND   com</Option>

						<Option Value="101000089| 0 | 0" >BILL DISCOUNTING CHARGES RECEIVED   com</Option>

						<Option Value="101000093| 0 | 0" >BOOKS & PERIODICALS   com</Option>

						<Option Value="101000993| 0 | 0" >BOUGHTOUT ITEM FOR FORCE MOTORS -RAW MATERIAL   MEPL</Option>

						<Option Value="101000957| 0 | 0" >BOUGHTOUT ITEM FOR JCB -RAW MATERIAL   ME</Option>

						<Option Value="101001186| 0 | 0" >BOUGHTOUT ITEM FOR -TACO ASSEMBLY   MEPL</Option>

						<Option Value="101000975| 0 | 0" >BOX TRANSFER CHARGES   </Option>

						<Option Value="101000333| 0 | 0" >C.I.BOARING PURCHASE A/C   MFPL</Option>

						<Option Value="101000334| 0 | 0" >C.I.INNOCULIN PURCHASE A/C   MFPL</Option>

						<Option Value="101000335| 0 | 0" >C.I.SCRAP PURCHASE A/C   MFPL</Option>

						<Option Value="101000336| 0 | 0" >C.R.C. SCRAP PURCHASE  A/C   MFPL</Option>

						<Option Value="101000337| 0 | 0" >CAPATIVE CON R.C.SAND   MFPL</Option>

						<Option Value="101000338| 0 | 0" >CAPATIVE CONS.SHELL-MOULD   MFPL</Option>

						<Option Value="101000006|101140073|0" >CAPITAL EXPS. OTHER BUILDING. D-11 (WIP)   DI</Option>

						<Option Value="101000006|101140090|0" >CAR - FORCE ONE SX  MH-11-BH-4110   MEPL</Option>

						<Option Value="101000897| 0 | 0" >CAR EXPENSES (BEAT+INNOVA)   MEPL</Option>

						<Option Value="101000902| 0 | 0" >CAR EXPENSES (ELENTRA+INDICA)   </Option>

						<Option Value="101000006|101140003|0" >CAR INNOVA MH-11-Y-7629   MEPL</Option>

						<Option Value="101000905| 0 | 0" >CAR REPAIRS AND MAINTENANCE   </Option>

						<Option Value="101000814| 0 | 0" >CAR-CHEVROLET BEAT LTO TCDI   ME</Option>

						<Option Value="101000006|101140076|0" >CAR-CHEVROLET BEAT LTO TCDI   ME</Option>

						<Option Value="101000101| 0 | 0" >CASTING PURCHASE A/C   com</Option>

						<Option Value="101000006|101140084|0" >CENTRALISED COOLENT SYSTEM   MEPL</Option>

						<Option Value="101000339| 0 | 0" >CI NICKEL PURCHASE   MFPL</Option>

						<Option Value="101001163| 0 | 0" >CLAIM FOR NON DELIVERING OF MATERIAL   MEPL</Option>

						<Option Value="101001028| 0 | 0" >CLEANING CHARGES   MEPL</Option>

						<Option Value="101000924| 0 | 0" >CLEARING FORWARDING CHARGES   </Option>

						<Option Value="101001173| 0 | 0" >CMM INSPECTION CHARGES (INCOME)   MEPL</Option>

						<Option Value="101000955| 0 | 0" >COMPENSATION  OF GENERATON CLAIM   MEPL</Option>

						<Option Value="101000340| 0 | 0" >COMPENSATION RECD. FROM INSURANCE   MFPL</Option>

						<Option Value="101000006|101140004|0" >COMPUTER   COM</Option>

						<Option Value="101000102| 0 | 0" >COMPUTER REPAIRING & MAINT   com</Option>

						<Option Value="101000257| 0 | 0" >CONFERANCE EXPENSES   msipl</Option>

						<Option Value="101000995| 0 | 0" >CONSULTANCY CHARGES   </Option>

						<Option Value="101000104| 0 | 0" >CONSULTATION FEES-TECHNICAL   com</Option>

						<Option Value="101000105| 0 | 0" >CONSUMABLE PURCHASE   com</Option>

						<Option Value="101000411| 0 | 0" >CONSUMABLE STORES   DI </Option>

						<Option Value="101000412| 0 | 0" >CONSUMABLE TOOLS   DI </Option>

						<Option Value="101000341| 0 | 0" >COPPER SCRAP PURCHASE A/C   MFPL</Option>

						<Option Value="101000109| 0 | 0" >CORE MAKING CHARGES   com</Option>

						<Option Value="101000342| 0 | 0" >CPC PUR.   MFPL</Option>

						<Option Value="101001084| 0 | 0" >CST 14% NO C FORM   MFPL</Option>

						<Option Value="101000006|101140069|0" >DEAD STOCK   DI</Option>

						<Option Value="101000695| 0 | 0" >DEEMED EXPORT   COM</Option>

						<Option Value="101000111| 0 | 0" >DEEMED EXPORT SALES   com</Option>

						<Option Value="101000978| 0 | 0" >DEPB CREDIT (BAL.)   MEPL</Option>

						<Option Value="101000992| 0 | 0" >DEPB CREDIT A/C   MEPL</Option>

						<Option Value="101000344| 0 | 0" >DEPB LICANCE   MFPL</Option>

						<Option Value="101000474| 0 | 0" >DEPB LICENCE PROF.EXPS.   MEPL</Option>

						<Option Value="101000862| 0 | 0" >DEPB PURCHASE A/C   ME</Option>

						<Option Value="101000006|101140005|0" >DIES & FIXTURE   DI</Option>

						<Option Value="101000863| 0 | 0" >DIMINUTION IN VALUE OF SHARES   </Option>

						<Option Value="101000413| 0 | 0" >DISCOUNT RECEIVED ACCOUNT   DI </Option>

						<Option Value="101000959| 0 | 0" >DIVIDEND RECEIVED - KUB BANK LIMITED   DI</Option>

						<Option Value="101000691| 0 | 0" >DIVIDEND RECEIVED A/C   </Option>

						<Option Value="101000488| 0 | 0" >DOMESTIC PACKING   MEPL</Option>

						<Option Value="101000112| 0 | 0" >DONATION   com</Option>

						<Option Value="101000117| 0 | 0" >ELECTRIC INSPECTION FEES   com</Option>

						<Option Value="101001123| 0 | 0" >ELECTRICAL LINING EXPENSES   MFPL</Option>

						<Option Value="101000788| 0 | 0" >ELECTRICITY CHARGES   DI</Option>

						<Option Value="101001016| 0 | 0" >ELECTRICITY DUTY EXCEMPTION (H-21)   MEPL</Option>

						<Option Value="101001017| 0 | 0" >ELECTRICITY DUTY EXCEMPTION (H-25)   MEPL</Option>

						<Option Value="101000006|101140006|0" >ELECTRIFICATION   DI/MFPL</Option>

						<Option Value="101000006|101140081|0" >ELECTRIFICATION H-25   H21 WIP</Option>

						<Option Value="101000006|101140008|0" >ELECTRIFICATION U-1   MEPL</Option>

						<Option Value="101000006|101140009|0" >ELECTRIFICATION U-2   MEPL</Option>

						<Option Value="101000006|101140010|0" >ELECTRIFICATION WIP  (H-21)   MEPL</Option>

						<Option Value="101000006|101140011|0" >ELECTRIFICATION WIP (H-25)   MEPL</Option>

						<Option Value="101000006|101140064|0" >ERECTION  CHARGES   DI</Option>

						<Option Value="101000982| 0 | 0" >ERP SOFTWARE AMC CHARGES   ME</Option>

						<Option Value="101000689| 0 | 0" >ESCORT AND OCTROI EXPENSES   </Option>

						<Option Value="101000918| 0 | 0" >ESCORT/OCTORI REFUND A/C   ME</Option>

						<Option Value="101000119| 0 | 0" >E-TDS FILING FEE   com</Option>

						<Option Value="101000674| 0 | 0" >EX.DUTY ON SALES RET.(LAPSED)   COM</Option>

						<Option Value="101000675| 0 | 0" >EXCISE APPEAL FILING FEE   COM</Option>

						<Option Value="101001039| 0 | 0" >EXCISE DUTY LAPSED   </Option>

						<Option Value="101000907| 0 | 0" >EXCISE DUTY ON DRAWING & DESIGN   MEPL</Option>

						<Option Value="101000676| 0 | 0" >EXCISE DUTY PENALTY   COM</Option>

						<Option Value="101000906| 0 | 0" >EXCISE REFUND (DRAWING & DESIGN)   ME</Option>

						<Option Value="101000692| 0 | 0" >EXCISE REFUND ACCOUNT   </Option>

						<Option Value="101000122| 0 | 0" >EXHIBITION EXPENSES   com</Option>

						<Option Value="101000123| 0 | 0" >EXPORT- AIR FREIGHT   MEPL</Option>

						<Option Value="101000124| 0 | 0" >EXPORT EXPENSES (OTHERS)   MEPL</Option>

						<Option Value="101000041| 0 | 0" >EXPORT SALES   COM</Option>

						<Option Value="101000490| 0 | 0" >EXPORT-CARRIAGE INWARD   MEPL</Option>

						<Option Value="101000491| 0 | 0" >EXPORT-CONSUMABLES   MEPL</Option>

						<Option Value="101000492| 0 | 0" >EXPORT-ELECTROPLATING CHARGES   MEPL</Option>

						<Option Value="101000493| 0 | 0" >EXPORT-MACHINING CHARGES   MEPL</Option>

						<Option Value="101000496| 0 | 0" >EXPORT-PACKING   MEPL</Option>

						<Option Value="101000497| 0 | 0" >EXPORT-REJECTION & REWORK   MEPL</Option>

						<Option Value="101000498| 0 | 0" >EXPORT-TOOLING   MEPL</Option>

						<Option Value="101000499| 0 | 0" >EXPORT-TRANSPORT   MEPL</Option>

						<Option Value="101000415| 0 | 0" >FACOTRY INSURANCE   DI </Option>

						<Option Value="101000006|101140013|0" >FACTORY BUILDING - WIP (H-25)   MEPL</Option>

						<Option Value="101000006|101140078|0" >FACTORY BUILDING (CF)   DI</Option>

						<Option Value="101000006|101140082|0" >FACTORY BUILDING H-25   FB H-25</Option>

						<Option Value="101000006|101140094|0" >FACTORY BUILDING H-25 PART-II   UNIT-IV (WIP)   MEPL</Option>

						<Option Value="101000350| 0 | 0" >FACTORY BUILDING REPAIRS MAINT   MFPL</Option>

						<Option Value="101000006|101140014|0" >FACTORY BUILDING U-1   MEPL/MFPL</Option>

						<Option Value="101000006|101140015|0" >FACTORY BUILDING U-2   MEPL/MFPL</Option>

						<Option Value="101000006|101140086|0" >FACTORY EQUIPMENTS   </Option>

						<Option Value="101000125| 0 | 0" >FACTORY EXPENSES   com</Option>

						<Option Value="101000126| 0 | 0" >FACTORY INSPECTION FEES   com</Option>

						<Option Value="101000127| 0 | 0" >FACTORY LICENCE FEES   com</Option>

						<Option Value="101000352| 0 | 0" >FERRO CHROMIMUM PURCHASE A/C   MFPL</Option>

						<Option Value="101000353| 0 | 0" >FERRO MANGANSE PURCHASE A/C   MFPL</Option>

						<Option Value="101000354| 0 | 0" >FERRO MOLLY PURCHASE A\C   MFPL</Option>

						<Option Value="101000355| 0 | 0" >FERRO PHOSPORUS PURCHASE A/C   MFPL</Option>

						<Option Value="101000356| 0 | 0" >FERRO SILICON MANGANSE PURCHASES A/C   MFPL</Option>

						<Option Value="101000357| 0 | 0" >FERRO SILICON PURCHASE A/C   MFPL</Option>

						<Option Value="101000130| 0 | 0" >FESTIVAL EXPENSES   com</Option>

						<Option Value="101000131| 0 | 0" >FETTLING & PAINTING & GATE CUTTING & OTHER CHRGES   com</Option>

						<Option Value="101000971| 0 | 0" >FETTLING CHARGES   </Option>

						<Option Value="101000837| 0 | 0" >FINE   MFPL</Option>

						<Option Value="101000133| 0 | 0" >FINE RECOVERY A/C   com</Option>

						<Option Value="101000134| 0 | 0" >FOREIGN TOUR EXPENSES   com</Option>

						<Option Value="101000006|101140017|0" >FORKLIFT TRUCK   MEPL</Option>

						<Option Value="101000416| 0 | 0" >FOUNDRY EXPENSES   DI </Option>

						<Option Value="101000006|101140088|0" >FREEHOLD LAND-NAGEWADI TAL. & DIST.SATARA (GAT NO.291)   MEPL</Option>

						<Option Value="101000501| 0 | 0" >FREEHOLD PLOT NAIGAON KESURDI(INVESTMESNT)   MEPL</Option>

						<Option Value="101000006|101140019|0" >FREEHOLD PLOT-KESURDI NAIGAON(ASSET)   MEPL</Option>

						<Option Value="101001134| 0 | 0" >FURNACE HEAT CHARGES   MSIPL</Option>

						<Option Value="101000358| 0 | 0" >FURNACE LINING EXPENSES   MFPL</Option>

						<Option Value="101000006|101140068|0" >FURNITURE   DI</Option>

						<Option Value="101000006|101140074|0" >FURNITURE & DEAD STOCK H-25   MEPL</Option>

						<Option Value="101000006|101140021|0" >FURNITURE & DEAD STOCK U-1   MEPL</Option>

						<Option Value="101000006|101140022|0" >FURNITURE & DEAD STOCK U-2   MEPL</Option>

						<Option Value="101000135| 0 | 0" >GARDENING EXPENSES   com</Option>

						<Option Value="101000359| 0 | 0" >GAS PURCHASE (SAND-RECLAMATION)   MFPL</Option>

						<Option Value="101000006|101140023|0" >GATE AND WATCHMAN CABIN   MSIPL</Option>

						<Option Value="101000973| 0 | 0" >GATE CUTTING CHARGES   </Option>

						<Option Value="101000136| 0 | 0" >GENERAL REPAIRS & MAINT   com</Option>

						<Option Value="101000138| 0 | 0" >GIFTS & PRESENTATION   com</Option>

						<Option Value="101000913| 0 | 0" >GRAMPANCHAYAT TAX   MSIPL</Option>

						<Option Value="101000360| 0 | 0" >HARDNER PURCHASE A/C   MFPL</Option>

						<Option Value="101000858| 0 | 0" >HOLIDAY RESORT TIME SHARES DIMINISHED   MFPL</Option>

						<Option Value="101000268| 0 | 0" >HOUSEKEEPING  CHARGES   msipl</Option>

						<Option Value="101000508| 0 | 0" >INCOME TAX APPEAL FILING FEES   MEPL</Option>

						<Option Value="101000509| 0 | 0" >INCOME TAX FILING FEES   MEPL</Option>

						<Option Value="101001011| 0 | 0" >INCOME TAX REFUND (A.Y.2004-05)   ME</Option>

						<Option Value="101000418| 0 | 0" >INDUCTION FURNASE LINING CHARGES   DI </Option>

						<Option Value="101001096| 0 | 0" >INDUSTRIAL PROMOTION SUBSIDY (IPS) 2013-14   DI</Option>

						<Option Value="101001119| 0 | 0" >INDUSTRIAL PROMOTION SUBSIDY (IPS) 2014-15   MEPL</Option>

						<Option Value="101000939| 0 | 0" >INDUSTRIAL PROMOTION SUBSIDY (IPS) MEGA PROJECT  2011-12   MEPL</Option>

						<Option Value="101001026| 0 | 0" >INDUSTRIAL PROMOTION SUBSIDY (IPS) MEGA PROJECT  2012-13   MEPL</Option>

						<Option Value="101000936| 0 | 0" >INDUSTRIAL PROMOTION SUBSIDY-EXPANSION-PSI 2007-12   </Option>

						<Option Value="101000419| 0 | 0" >INSPECTION CHARGES   DI </Option>

						<Option Value="101000269| 0 | 0" >INSPECTION FEES TRANSFORMER   msipl</Option>

						<Option Value="101000151| 0 | 0" >INSURANCE   com</Option>

						<Option Value="101000988| 0 | 0" >INSURANCE  CLAIM RECEIVED   ME</Option>

						<Option Value="101001030| 0 | 0" >INSURANCE-WINDMILL   ME</Option>

						<Option Value="101000954| 0 | 0" >INTEREST ON AXIS BANK FD   DI</Option>

						<Option Value="101001068| 0 | 0" >INTEREST ON FD SARASWAT CO-OP.BANK LTD. A/C NO.370   U-III</Option>

						<Option Value="101000524| 0 | 0" >INTEREST ON INCOME TAX REFUND   MEPL</Option>

						<Option Value="101000801| 0 | 0" >INTEREST ON RATE DIFFERENCE INVOICES   MSIPL</Option>

						<Option Value="101000877| 0 | 0" >INTEREST RECEIVED ON ADVANCES   </Option>

						<Option Value="101001138| 0 | 0" >INTEREST RECEIVED ON INVESTMENT   ME</Option>

						<Option Value="101000871| 0 | 0" >INTEREST RECEIVED ON MSEB DEPOSIT   DI</Option>

						<Option Value="101001124| 0 | 0" >INTEREST RECEIVED ON RECURING DEPOSIT   MFPL</Option>

						<Option Value="101001155| 0 | 0" >INTEREST RECEIVED ON ROHA MEGACITY DEVELOPERS LLP   </Option>

						<Option Value="101001108| 0 | 0" >INTEREST RECEIVED ON WATER DEPOSIT (MIDC)   MFPL</Option>

						<Option Value="101000994| 0 | 0" >INVESTMENT W/OFF A/C   </Option>

						<Option Value="101000154| 0 | 0" >ISO / TS / TPM / UNIDO EXPENSES   com</Option>

						<Option Value="101000006|101140024|0" >JIG DIES & FIXTURE U-1   MEPL</Option>

						<Option Value="101000006|101140025|0" >JIG DIES & FIXTURE U-2   MEPL</Option>

						<Option Value="101000301| 0 | 0" >JOB WORK CHARGES   msipl</Option>

						<Option Value="101000373| 0 | 0" >KEY MAN INSURANCE PREMIMUM   MFPL</Option>

						<Option Value="101000972| 0 | 0" >KNOCKOUT CHARGES   </Option>

						<Option Value="101000006|101140063|0" >LABORATORY EQUIPMENT   MSIPL</Option>

						<Option Value="101000374| 0 | 0" >LABORATORY EXPENSES   MFPL</Option>

						<Option Value="101000709| 0 | 0" >LABOUR CHARGES A/C   </Option>

						<Option Value="101000044| 0 | 0" >LABOUR PURCHASE ACCOUNT   COM</Option>

						<Option Value="101000038| 0 | 0" >LABOUR SALES ACCOUNT   COM</Option>

						<Option Value="101000006|101140077|0" >LAND (CF)   DI</Option>

						<Option Value="101000006|101140067|0" >LAND (LEASEHOLD)   MFPL</Option>

						<Option Value="101000006|101140085|0" >LAND (WINDMILL)   MEPL</Option>

						<Option Value="101000899| 0 | 0" >LATE DELIVERY EXTRA CHARGES   </Option>

						<Option Value="101000859| 0 | 0" >LEASE FOR EXPIRED PERIOD OF MIDC LAND   MFPL</Option>

						<Option Value="101000006|101140028|0" >LEASEHOLD LAND (PLOT NO.H-21)   MEPL</Option>

						<Option Value="101000006|101140093|0" >LEASEHOLD LAND (PLOT NO.H-25) PART-II   H25</Option>

						<Option Value="101000162| 0 | 0" >LEGAL EXPENSES   com</Option>

						<Option Value="101001136| 0 | 0" >LICENCE - FOCUS PRODUCT SCHEME   MEPL</Option>

						<Option Value="101001185| 0 | 0" >LICENCE - MERCHANDISE EXPORTS OF INDIA SCHEME (MEIS)   MEPL</Option>

						<Option Value="101000303| 0 | 0" >LICENCES RENEWAL FEES   msipl</Option>

						<Option Value="101000941| 0 | 0" >LICENSE (STATUS HOLDER INCENTIVE SCRIP)   MEPL</Option>

						<Option Value="101001079| 0 | 0" >LINER CUTTING CHARGES   MSIPL</Option>

						<Option Value="101000961| 0 | 0" >LOADING & UNLOADING CHARGES   ALL</Option>

						<Option Value="101001025| 0 | 0" >LOCAL BODY TAX (LBT)   MEPL</Option>

						<Option Value="101000164| 0 | 0" >LOCAL CONVEYANCE   com</Option>

						<Option Value="101001003| 0 | 0" >LOSS ON MOULDING BOXES SCRAP   DI</Option>

						<Option Value="101001160| 0 | 0" >LOSS ON SALE OF  PLANT & MACHINERY   MEPL</Option>

						<Option Value="101001002| 0 | 0" >LOSS ON SALE OF CAR   DI</Option>

						<Option Value="101000977| 0 | 0" >LOSS ON SALE OF DEPB LICENCE   MEPL</Option>

						<Option Value="101000590| 0 | 0" >LOSS ON SALE OF DSP BLACKROCK MUTUAL FUND   MEPL</Option>

						<Option Value="101001037| 0 | 0" >LOSS ON SALE OF SHARES/CONVERSION OF SHARES   MEPL</Option>

						<Option Value="101000378| 0 | 0" >M.S.ROUND BAR   MFPL</Option>

						<Option Value="101000379| 0 | 0" >M.S.SCRAP PURCHASE A/C   MFPL</Option>

						<Option Value="101000591| 0 | 0" >MACHINE SHOP EXPENSES   MEPL</Option>

						<Option Value="101000592| 0 | 0" >MACHINERY RENT PAID   MEPL</Option>

						<Option Value="101000710| 0 | 0" >MACHINING CHARGES   </Option>

						<Option Value="101000165| 0 | 0" >MACHINING/LABOUR CHARGES   com</Option>

						<Option Value="101000781| 0 | 0" >MANUFACTURING SALES RETURN   </Option>

						<Option Value="101000935| 0 | 0" >MANUFACTURING SALES RETURN SHELL MOULD   </Option>

						<Option Value="101000782| 0 | 0" >MANUFACTURING SALES RETURN-OMS   </Option>

						<Option Value="101000841| 0 | 0" >MAX NEWYORK LIFE PARTNER INSURANCE PREMIUM   MEPL</Option>

						<Option Value="101000380| 0 | 0" >MEMBERSHIP FEES A/C   MFPL</Option>

						<Option Value="101000595| 0 | 0" >MIDC EXPENSES   MEPL</Option>

						<Option Value="101001149| 0 | 0" >MIDC NAME CHANGE CHARGES   MSIPL</Option>

						<Option Value="101000167| 0 | 0" >MISC.INCOME   com</Option>

						<Option Value="101000168| 0 | 0" >MISCELLENIOUS EXPENSES.   com</Option>

						<Option Value="101000169| 0 | 0" >MOBILE EXPENSES   com</Option>

						<Option Value="101000306| 0 | 0" >MONITORING AGENCY FEES   msipl</Option>

						<Option Value="101000945| 0 | 0" >MONO RAIL C WIP W/OFF   MSIPL</Option>

						<Option Value="101000381| 0 | 0" >MOULDING CHARGES   MFPL</Option>

						<Option Value="101000307| 0 | 0" >MPC BOARD REGD. CHARGES   msipl</Option>

						<Option Value="101000384| 0 | 0" >NOTICE PAY A/C   COM</Option>

						<Option Value="101000006|101140033|0" >OFFICE BUILDING (PUNE FLAT)   MEPL</Option>

						<Option Value="101000006|101140034|0" >OFFICE BUILDING U-1   MEPL/MFPL</Option>

						<Option Value="101000006|101140035|0" >OFFICE BUILDING U-2   MEPL/MFPL</Option>

						<Option Value="101000006|101140036|0" >OFFICE EQUIPMENT   MEPL/MFPL</Option>

						<Option Value="101000172| 0 | 0" >OFFICE EXPENSES   com</Option>

						<Option Value="101000173| 0 | 0" >OFFICE -RENT   com</Option>

						<Option Value="101000962| 0 | 0" >OFFICERS CLUB EXPENSES   </Option>

						<Option Value="101000934| 0 | 0" >ONE MONTH NOTICE PAYMENT   ME</Option>

						<Option Value="101000385| 0 | 0" >OTHER RAW MATERIAL   MFPL</Option>

						<Option Value="101000310| 0 | 0" >P.F DAMAGES 09.10   msipl</Option>

						<Option Value="101000311| 0 | 0" >P.F. DAMAGES 08.09   msipl</Option>

						<Option Value="101000784| 0 | 0" >PACKING & FORWARDING-SALES   </Option>

						<Option Value="101000696| 0 | 0" >PACKING & FORWARIDNG PURCHASE   </Option>

						<Option Value="101000974| 0 | 0" >PAINTING CHARGES   </Option>

						<Option Value="101000849| 0 | 0" >PARTNERS REMUNERATION   </Option>

						<Option Value="101000006|101140037|0" >PATTERN   DI</Option>

						<Option Value="101000006|101140038|0" >PATTERN - JIG & DIES   MSIPL</Option>

						<Option Value="101000398| 0 | 0" >PATTERN MAINTAINCES CHARGES   COM</Option>

						<Option Value="101000772| 0 | 0" >PATTERN REPAIRS   MFPL</Option>

						<Option Value="101000937| 0 | 0" >PENALTY ON SERVICE TAX   ME</Option>

						<Option Value="101000844| 0 | 0" >PENALTY ON VAT TAX   </Option>

						<Option Value="101000312| 0 | 0" >PF DAMAGES RECOVERED   msipl</Option>

						<Option Value="101000183| 0 | 0" >PIG IRON   com</Option>

						<Option Value="101000006|101140039|0" >PLANT & MACHINERY   DI/MSIPL</Option>

						<Option Value="101000006|101140040|0" >PLANT & MACHINERY  (WIP)   DI</Option>

						<Option Value="101000006|101140072|0" >PLANT & MACHINERY (H-25) WIP   MEPL</Option>

						<Option Value="101000006|101140055|0" >PLANT & MACHINERY (WEIGHBRIDGE)   MFPL</Option>

						<Option Value="101000006|101140092|0" >PLANT & MACHINERY ERRECTION   DI</Option>

						<Option Value="101000006|101140079|0" >PLANT & MACHINERY H-25   H-21</Option>

						<Option Value="101000006|101140041|0" >PLANT & MACHINERY U-1   MEPL/MFPL</Option>

						<Option Value="101000006|101140042|0" >PLANT & MACHINERY U-2   MEPL/MFPL</Option>

						<Option Value="101000006|101140043|0" >PLANT & MACHINERY U-3   MEPL</Option>

						<Option Value="101000184| 0 | 0" >POLUTION CONTROL FEES   com</Option>

						<Option Value="101000185| 0 | 0" >POSTAGE & COURIER CHARGES   com</Option>

						<Option Value="101000603| 0 | 0" >POWDER COATING CHARGES(DOMESTIC)   MEPL</Option>

						<Option Value="101000604| 0 | 0" >POWDER COATING CHARGES(EXPORT)   MEPL</Option>

						<Option Value="101000006|101140095|0" >POWDER COATING WIP   U-III</Option>

						<Option Value="101001222| 0 | 0" >POWER & ELECTRICITY CHARGES - POWDER COATING PLANT   MFPL</Option>

						<Option Value="101000874| 0 | 0" >POWER & ELECTRICITY CHARGES (H-25)   ME H25</Option>

						<Option Value="101000186| 0 | 0" >POWER & ELECTRICITY EXPENSES   com</Option>

						<Option Value="101001140| 0 | 0" >POWER CONSULTANCY CHARGES   DI/MFPL</Option>

						<Option Value="101000188| 0 | 0" >PRINTING & STATIONERY   com</Option>

						<Option Value="101000976| 0 | 0" >PRIOR YEAR ADJUSTMENT CST 2%   </Option>

						<Option Value="101001051| 0 | 0" >PRIOR YEAR MOBILE EXPENSES   MSIPL</Option>

						<Option Value="101000192| 0 | 0" >PROFESSION TAX (COMPANY)   com</Option>

						<Option Value="101000194| 0 | 0" >PROFESSIONAL CHARGES   com</Option>

						<Option Value="101000609| 0 | 0" >PROFIT ON SALE OF  FREEHOLD LAND-KHINDWADI   MEPL</Option>

						<Option Value="101000779| 0 | 0" >PROFIT ON SALE OF DEPB LICENCE   MEPL</Option>

						<Option Value="101001152| 0 | 0" >PROFIT ON SALE OF FIXTURE   MEPL</Option>

						<Option Value="101001194| 0 | 0" >PROFIT ON SALE OF INNOVA CAR (MH-11-Y-7629)   MEPL</Option>

						<Option Value="101000195| 0 | 0" >PROFIT ON SALE OF MACHINERY   com</Option>

						<Option Value="101000196| 0 | 0" >PROFIT ON SALE OF RELIANCE GROWTH FUND (D)   com</Option>

						<Option Value="101000884| 0 | 0" >PROFIT ON SALE OF SCRAP CAR MH-18 B - 875   </Option>

						<Option Value="101000197| 0 | 0" >PROFIT ON SALE OF SHARES   com</Option>

						<Option Value="101000930| 0 | 0" >PROFIT/LOSS ON SALE OF SHARES   ME</Option>

						<Option Value="101000866| 0 | 0" >PROVISION FOR RATE AMENDMENT   </Option>

						<Option Value="101001174| 0 | 0" >PROVISION FOR RATE REDUCTION   </Option>

						<Option Value="101000433| 0 | 0" >PUR S.G CRC SCRAP   DI </Option>

						<Option Value="101000434| 0 | 0" >PUR. C.I.SCRAP   DI </Option>

						<Option Value="101000435| 0 | 0" >PUR.ALUMINIUM SCRAP   DI </Option>

						<Option Value="101000436| 0 | 0" >PUR.C.I.BOARING   DI </Option>

						<Option Value="101000437| 0 | 0" >PUR.C.I.CASTINGS   DI </Option>

						<Option Value="101000438| 0 | 0" >PUR.COKE   DI </Option>

						<Option Value="101000611| 0 | 0" >PUR.CONS.STORES   MEPL</Option>

						<Option Value="101000612| 0 | 0" >PUR.CONS.TOOLS   MEPL</Option>

						<Option Value="101000439| 0 | 0" >PUR.M.S.SCRAP   DI </Option>

						<Option Value="101000440| 0 | 0" >PUR.OTHER RAW MATERIAL   DI </Option>

						<Option Value="101000441| 0 | 0" >PUR.PIG IRON   DI </Option>

						<Option Value="101000442| 0 | 0" >PUR:-M.S.ROUND BAR   DI </Option>

						<Option Value="101000613| 0 | 0" >PURCHASE (CI+SGI) CASTINGS   MEPL</Option>

						<Option Value="101000614| 0 | 0" >PURCHASE CI SCRAP   MEPL</Option>

						<Option Value="101001000| 0 | 0" >PURCHASE CI/SGI CASTINGS H-25   H25</Option>

						<Option Value="101000615| 0 | 0" >PURCHASE EXPORT CASTING (SGI+CI)   MEPL</Option>

						<Option Value="101000723| 0 | 0" >PURCHASE OF ALUMN.CASTINGS (DOM+EXPORT)   </Option>

						<Option Value="101000387| 0 | 0" >PURCHASE OF CONSUMABLE STORES   MFPL</Option>

						<Option Value="101001081| 0 | 0" >PURCHASE RETURN   </Option>

						<Option Value="101000764| 0 | 0" >PURCHASE RETURN - ALUMN.CASTINGS -DOMESTIC    MEPL</Option>

						<Option Value="101001001| 0 | 0" >PURCHASE RETURN - CI/SGI CASTINGS H-25    H25</Option>

						<Option Value="101000762| 0 | 0" >PURCHASE RETURN - CI/SGI CASTINGS-DOMESTIC    MEPL</Option>

						<Option Value="101000763| 0 | 0" >PURCHASE RETURN - S.G.I CASTINGS-EXPORT    MEPL</Option>

						<Option Value="101000688| 0 | 0" >PURCHASE S G I CASTING   MSIPL</Option>

						<Option Value="101000616| 0 | 0" >PURCHASE SGI SCRAP   MEPL</Option>

						<Option Value="101000443| 0 | 0" >PURCHASE SHELL MOULD (CORE MAKING)   DI </Option>

						<Option Value="101001099| 0 | 0" >PURCHASE TIN INGOT   DI</Option>

						<Option Value="101000444| 0 | 0" >PURCHASE-C.P.COKE   DI </Option>

						<Option Value="101000314| 0 | 0" >QUALITY CONTROL EXPS   msipl</Option>

						<Option Value="101000315| 0 | 0" >R.M. (OTHER)   msipl</Option>

						<Option Value="101000205| 0 | 0" >R.O.C. EXPENSES   com</Option>

						<Option Value="101000915| 0 | 0" >RATE DIFFERANCE   </Option>

						<Option Value="101000970| 0 | 0" >RATE DIFFERANCE OMS   </Option>

						<Option Value="101000316| 0 | 0" >RAW MATERIAL PURCHASE   msipl</Option>

						<Option Value="101000388| 0 | 0" >RAW SILICA SAND PURCHASE A/C   MFPL</Option>

						<Option Value="101000943| 0 | 0" >RAW SILICA SAND RECLAIMED PURCHASE   </Option>

						<Option Value="101001007| 0 | 0" >REC TRADE  INCOME (INDIAN ENERGY EXCHANGE)   ME</Option>

						<Option Value="101001008| 0 | 0" >REC TRADE EXPENSES   ME</Option>

						<Option Value="101000914| 0 | 0" >REJECTION CHARGES   </Option>

						<Option Value="101000445| 0 | 0" >REJECTION INWORD EXPENSES   DI </Option>

						<Option Value="101000207| 0 | 0" >RENT ,RATES &TAXES   com</Option>

						<Option Value="101001220| 0 | 0" >RENT FOR POWDER COATING PLANT   MFPL</Option>

						<Option Value="101000318| 0 | 0" >RENT TO MUTHA ENGINEERING   msipl</Option>

						<Option Value="101000622| 0 | 0" >RENTING OF IMMOVIABLE PROPERTY-CORP.OFFICE   MEPL</Option>

						<Option Value="101000045| 0 | 0" >REPAIR SALES ACCOUNT   COM</Option>

						<Option Value="101000208| 0 | 0" >REPAIRS & MAINTAINANCE-GENERAL   com</Option>

						<Option Value="101000209| 0 | 0" >REPAIRS & MAINTAINANCE-MACHINERY   com</Option>

						<Option Value="101000389| 0 | 0" >RESIN COATED SAND PURCHASE A/C   MFPL</Option>

						<Option Value="101000390| 0 | 0" >RESIN LIQUID PURCHASE A/C   MFPL</Option>

						<Option Value="101000211| 0 | 0" >RETAINERSHIP CHARGES   com</Option>

						<Option Value="101001013| 0 | 0" >REWORK CHARGES - DOMESTIC   ME</Option>

						<Option Value="101000212| 0 | 0" >ROC FILING FEES   com</Option>

						<Option Value="101000009| 0 | 0" >ROUNDING OFF ACCOUNT   erp a/c</Option>

						<Option Value="101000780| 0 | 0" >SALE ALUMINIUM  BORING   MEPL</Option>

						<Option Value="101001040| 0 | 0" >SALE ALUMINIUM  SCRAP   MEPL</Option>

						<Option Value="101000767| 0 | 0" >SALE ALUMN..MACH.CASTINGS -SALES RETURN   MEPL</Option>

						<Option Value="101000786| 0 | 0" >SALE ALUMN.CASTING OMS 2%   DI</Option>

						<Option Value="101000624| 0 | 0" >SALE C.I.BOARING   MEPL</Option>

						<Option Value="101000948| 0 | 0" >SALE C.I.BOARING SALES RETURN   ME</Option>

						<Option Value="101000785| 0 | 0" >SALE C.I.CASTINGS OMS 2%   DI</Option>

						<Option Value="101000776| 0 | 0" >SALE C.I.MACH.CASTINGS -OMS 2%   MEPL</Option>

						<Option Value="101000766| 0 | 0" >SALE C.I.MACH.CASTINGS -SALES RETURN   MEPL</Option>

						<Option Value="101001207| 0 | 0" >SALE CASTINGS EXPORT  (U-III)   MSIPL</Option>

						<Option Value="101000998| 0 | 0" >SALE CI/SGI CASTINGS    H-25   H25</Option>

						<Option Value="101000999| 0 | 0" >SALE CI/SGI CASTINGS - SALES RETURN H-25   H25</Option>

						<Option Value="101000996| 0 | 0" >SALE CI/SGI MACHINED CASTING  H-25   H25</Option>

						<Option Value="101000997| 0 | 0" >SALE CI/SGI MACHINED CASTING - SALE RETURN  H25   H25</Option>

						<Option Value="101000789| 0 | 0" >SALE- CORES & MOULD   </Option>

						<Option Value="101000951| 0 | 0" >SALE MACH.CASTINGS EXPORT-SALE RETURN   ME</Option>

						<Option Value="101000777| 0 | 0" >SALE MACH.CASTINGS -OMS2% SALES RETURN   MEPL</Option>

						<Option Value="101001070| 0 | 0" >SALE MACHINING DEFECTIVES- REJECTION   MEPL</Option>

						<Option Value="101000950| 0 | 0" >SALE MACHINING/LABOUR CHARGES SALE RETURN   ME</Option>

						<Option Value="101000797| 0 | 0" >SALE MOULDING BOX   DI</Option>

						<Option Value="101000625| 0 | 0" >SALE OF DEPB LICENCE   MEPL</Option>

						<Option Value="101000980| 0 | 0" >SALE OF WIND POWER ELECTRICITY   MEPL</Option>

						<Option Value="101000790| 0 | 0" >SALE OTHER   DI</Option>

						<Option Value="101000833| 0 | 0" >SALE PIG IRON   DI</Option>

						<Option Value="101000765| 0 | 0" >SALE PURCHASE (REJ.) ALUMN.CASTINGS -EXPORT   MEPL</Option>

						<Option Value="101001075| 0 | 0" >SALE RATE REDUCTION ALUMN.CASTINGS   DI</Option>

						<Option Value="101001074| 0 | 0" >SALE RATE REDUCTION C.I.CASTINGS   DI</Option>

						<Option Value="101000931| 0 | 0" >SALE RATE REDUCTION -DOMESTIC   MEPL</Option>

						<Option Value="101001209| 0 | 0" >SALE RATE REDUCTION -DOMESTIC H-25   MEPL II</Option>

						<Option Value="101000933| 0 | 0" >SALE RATE REDUCTION -EXPORT   MEPL</Option>

						<Option Value="101000932| 0 | 0" >SALE RATE REDUCTION OMS 2%   ME</Option>

						<Option Value="101000944| 0 | 0" >SALE RAW SILICA SAND RECLAIMED   </Option>

						<Option Value="101000949| 0 | 0" >SALE S.G.I.BOARING SALE RETURN   MEPL</Option>

						<Option Value="101000829| 0 | 0" >SALE TAX DUES   DI</Option>

						<Option Value="101000629| 0 | 0" >SALE-AIR FREIGHT-(INCOME)   MEPL</Option>

						<Option Value="101000630| 0 | 0" >SALE-MACHINED CASTINGS-DOMESTIC   MEPL</Option>

						<Option Value="101000631| 0 | 0" >SALE-MACHINED CASTINGS-EXPORT   MEPL</Option>

						<Option Value="101000773| 0 | 0" >SALE-MACHINING/LABOUR CHARGES   </Option>

						<Option Value="101000632| 0 | 0" >SALE-PLANT &MACHINERY U3   MEPL</Option>

						<Option Value="101000392| 0 | 0" >SALES - EXPORT   MFPL</Option>

						<Option Value="101001184| 0 | 0" >SALES  TAX APPEAL FILING FEES   MEPL</Option>

						<Option Value="101000633| 0 | 0" >SALES - TOOL COST   MEPL</Option>

						<Option Value="101001218| 0 | 0" >SALES - TOOLS COST EXPORT   MEPL</Option>

						<Option Value="101000447| 0 | 0" >SALES ALUMN.CASTINGS   DI </Option>

						<Option Value="101001172| 0 | 0" >SALES ALUMN.CASTINGS - SALES RETURN   DI</Option>

						<Option Value="101000774| 0 | 0" >SALES ALUMN.CASTINGS (DOMESTIC)   </Option>

						<Option Value="101000775| 0 | 0" >SALES ALUMN.CASTINGS (EXPORT)   </Option>

						<Option Value="101001082| 0 | 0" >SALES ALUMN.CASTINGS (OMS 2%)   ME</Option>

						<Option Value="101001083| 0 | 0" >SALES ALUMN.CASTINGS (OMS 2%) SALES RETURN   ME</Option>

						<Option Value="101000448| 0 | 0" >SALES C.I.CASTINGS   COM</Option>

						<Option Value="101001170| 0 | 0" >SALES C.I.CASTINGS - SALES RETURN   DI</Option>

						<Option Value="101001171| 0 | 0" >SALES C.I.CASTINGS OMS 2% - SALES RETURN   DI</Option>

						<Option Value="101000634| 0 | 0" >SALES C.I.SCRAP   MEPL</Option>

						<Option Value="101001085| 0 | 0" >SALES CAS 4   </Option>

						<Option Value="101000783| 0 | 0" >SALES CASTING -OMS   </Option>

						<Option Value="101001010| 0 | 0" >SALES COMPUTER   </Option>

						<Option Value="101000891| 0 | 0" >SALES CONSUMABLE MATERIAL   MSIPL</Option>

						<Option Value="101000865| 0 | 0" >SALES CREDIT NOTE ACCOUNTS ONLY   MSIPL</Option>

						<Option Value="101001169| 0 | 0" >SALES CREDIT NOTE ACCOUNTS ONLY - OMS   MSIPL</Option>

						<Option Value="101000460| 0 | 0" >SALES OF DEPB LICENCE   MEPL/DI</Option>

						<Option Value="101000451| 0 | 0" >SALES- PLANT & MACHINERY   DI </Option>

						<Option Value="101000637| 0 | 0" >SALES PROMOTION   COM</Option>

						<Option Value="101000394| 0 | 0" >SALES R.C. SAND   MFPL</Option>

						<Option Value="101000890| 0 | 0" >SALES RAW MATERIAL   MSIPL</Option>

						<Option Value="101000319| 0 | 0" >SALES S. G. IRON CASTINGS   COM</Option>

						<Option Value="101000864| 0 | 0" >SALES S. G. IRON CASTINGS- OMS   MSIPL</Option>

						<Option Value="101000638| 0 | 0" >SALES S.G.I. SCRAP   MEPL</Option>

						<Option Value="101000639| 0 | 0" >SALES S.G.I.BOARING   MEPL</Option>

						<Option Value="101000395| 0 | 0" >SALES SHELL MOULD   MFPL</Option>

						<Option Value="101001077| 0 | 0" >SALES TAX REFUND 2005-06   MEPL</Option>

						<Option Value="101000456| 0 | 0" >SALES-C. I. BOARING   DI </Option>

						<Option Value="101000641| 0 | 0" >SALES-MACHINING CHARGES   MEPL</Option>

						<Option Value="101000642| 0 | 0" >SALES-TOOL/DRILL/TAPS (SCRAP)   MEPL</Option>

						<Option Value="101001071| 0 | 0" >SALES-TOOLS & EQUIPMENTS   MFPL</Option>

						<Option Value="101000947| 0 | 0" >SCHEDULE ADHELS PENALTY   ME</Option>

						<Option Value="101000822| 0 | 0" >SCHEME OF DUTY DRAWBACK RECEIPT   MEPL</Option>

						<Option Value="101000039| 0 | 0" >SCRAP SALES   COM</Option>

						<Option Value="101000215| 0 | 0" >SECURITY EXPENSES   com</Option>

						<Option Value="101000938| 0 | 0" >SEGREGATION & REWORK CHARGES   </Option>

						<Option Value="101000216| 0 | 0" >SEMINAR & CONFERANCE CHARGES   com</Option>

						<Option Value="101000321| 0 | 0" >SHOTBLASTING EXPS   msipl</Option>

						<Option Value="101001120| 0 | 0" >SOCIAL WELFARE EXPENSES   MFPL</Option>

						<Option Value="101001052| 0 | 0" >SOFTWARE EXPENSES   MEPL</Option>

						<Option Value="101000322| 0 | 0" >SPECTRO TESTING  CHARGES   msipl</Option>

						<Option Value="101001135| 0 | 0" >SPILLAGE COLLECTION CHARGES   MSIPL</Option>

						<Option Value="101000896| 0 | 0" >SPONSORSHIP CHARGES   </Option>

						<Option Value="101000221| 0 | 0" >SUBSCRIPTION   com</Option>

						<Option Value="101000873| 0 | 0" >SUNDRY CREDITORS W/OFF ACCOUNT   MFPL</Option>

						<Option Value="101001100| 0 | 0" >SUNDRY DEBTORS SETTLEMENT ACCOUNT   MEPL </Option>

						<Option Value="101001101| 0 | 0" >SUNDRY DEBTORS SETTLMENT A/C   MEPL</Option>

						<Option Value="101000651| 0 | 0" >SUNDRY DRS. WRITTEN/OFF   MEPL</Option>

						<Option Value="101001129| 0 | 0" >SWACHH BAHART CESS   MEPL</Option>

						<Option Value="101000800| 0 | 0" >T.S.PROGRAM EXPENSES   </Option>

						<Option Value="101000238| 0 | 0" >TEA & HOTEL EXP (GUEST)   com</Option>

						<Option Value="101000241| 0 | 0" >TELEPHONE CHARGES   com</Option>

						<Option Value="101000403| 0 | 0" >TIN PURCHASE A/C   MFPL</Option>

						<Option Value="101000006|101140066|0" >TOOLS & EQUIPMENT   MFPL</Option>

						<Option Value="101000006|101140045|0" >TOOLS & EQUIPMENT U-1   MEPL</Option>

						<Option Value="101000006|101140046|0" >TOOLS & EQUIPMENT U-2   MEPL</Option>

						<Option Value="101000989| 0 | 0" >TOOLS GRINDING/RESHARPNING CHARGES-DOMESTIC   ME</Option>

						<Option Value="101000990| 0 | 0" >TOOLS GRINDING/RESHARPNING CHARGES-EXPORT   ME</Option>

						<Option Value="101000657| 0 | 0" >TPM MEMBERSHIP FEES   MEPL</Option>

						<Option Value="101000006|101140080|0" >TRACTOR TRAILOR RED (TROLLEY)   MEPL</Option>

						<Option Value="101000099| 0 | 0" >TRANSPORT  CHARGES (INWARD)   com</Option>

						<Option Value="101000242| 0 | 0" >TRANSPORT CHARGES (OUTWARD)   com</Option>

						<Option Value="101000461| 0 | 0" >TRANSPORT CHARGES (SALES)   DI </Option>

						<Option Value="101000243| 0 | 0" >TRANSPORT CHARGES LOCAL   com</Option>

						<Option Value="101000658| 0 | 0" >TRAVELLING EXPENSES   COM</Option>

						<Option Value="101000006|101140047|0" >TYPE WRITER   MEPL</Option>

						<Option Value="101000981| 0 | 0" >VALUE OF UNITS GENERATED-WTG   MEPL</Option>

						<Option Value="101001012| 0 | 0" >VANEDIUM PURCHASE   </Option>

						<Option Value="101000663| 0 | 0" >VAT REDUCTION 2%   MEPL</Option>

						<Option Value="101001131| 0 | 0" >VAT REFUND 2010-11   DI</Option>

						<Option Value="101000960| 0 | 0" >VAT TAX APPEAL FEE   MEPL</Option>

						<Option Value="101000842| 0 | 0" >VAT TAX DUES   </Option>

						<Option Value="101000006|101140091|0" >VEHICLE - FORD ECO SPORTS   DI</Option>

						<Option Value="101000006|101140097|0" >VEHICLE - INNOVA CRYSTA MH-11-BV-7022   DI</Option>

						<Option Value="101000248| 0 | 0" >VEHICLE REPAIRS & MAINT   com</Option>

						<Option Value="101000667| 0 | 0" >VENDOR MACHINE SHOP EXPS.   MEPL</Option>

						<Option Value="101000669| 0 | 0" >WARRANTY CLAIM   MEPL</Option>

						<Option Value="101000251| 0 | 0" >WATER CHARGES   com</Option>

						<Option Value="101001221| 0 | 0" >WATER CHARGES - POWDER COATING PLANT   MFPL</Option>

						<Option Value="101000875| 0 | 0" >WATER CHARGES (H-25)   MEPL</Option>

						<Option Value="101000465| 0 | 0" >WATER PLOUTION   DI </Option>

						<Option Value="101000253| 0 | 0" >WEIGHMENT CHARGES   com</Option>

						<Option Value="101000929| 0 | 0" >WIND ENERGY CHARGES RECEIVED FROM MSEDCL   MEPL</Option>

						<Option Value="101000006|101140083|0" >WINDMILL   MEPL</Option>

						<Option Value="101000880| 0 | 0" >WINDMILL EXPENSES   MEPL</Option>

						<Option Value="101000006|101140089|0" >WIP LINER PROJECT   </Option>

						<Option Value="101000006|101140096|0" >WIP PLANT & MACHINERY (POWDER COATING PLANT)   MFPL</Option>

						<Option Value="101000006|101140075|0" >WIP PLANT AND MACHINARY   MSIPL</Option>

						<Option Value="101000006|101140065|0" >WIP VINAR & PAINT SHOP PROJECT   MFPL</Option>

						<Option Value="101001143| 0 | 0" >WMDC DUES   DI</Option>

						<Option Value="101000006|101140070|0" >WORKS EQUIPMENTS   DI</Option>

						<Option Value="101000815| 0 | 0" >XEROX MACHINE RENT PAID   ME</Option>

				</select>
			</Td>
		</tr>
		<tr>
			<td width="05%" colspan="05" align="left"> &nbsp</td>
			<td Width="25%" colspan="25" align="left">
				<label class="caption" >Sales GL</label>
			</td>
			<Td Width="70%" colspan="70" align="left">
				<Select id="drpSaleGlAcno" name="drpSaleGlAcno"  TabIndex="29" >
				<Option Value="0">&nbsp;</Option>
				
					<Option Value="101000255| 0 | 0" >ANNEALING  CHARGES   msipl</Option>

					<Option Value="101000040| 0 | 0" >APPRICIATION VALUE OF SHARE   MEPL</Option>

					<Option Value="101000006|101140071|0" >AUTO TRUCK TRIALOR   DI</Option>

					<Option Value="101000086| 0 | 0" >BANK DIVIDEND   com</Option>

					<Option Value="101000089| 0 | 0" >BILL DISCOUNTING CHARGES RECEIVED   com</Option>

					<Option Value="101000993| 0 | 0" >BOUGHTOUT ITEM FOR FORCE MOTORS -RAW MATERIAL   MEPL</Option>

					<Option Value="101000957| 0 | 0" >BOUGHTOUT ITEM FOR JCB -RAW MATERIAL   ME</Option>

					<Option Value="101001186| 0 | 0" >BOUGHTOUT ITEM FOR -TACO ASSEMBLY   MEPL</Option>

					<Option Value="101000975| 0 | 0" >BOX TRANSFER CHARGES   </Option>

					<Option Value="101000333| 0 | 0" >C.I.BOARING PURCHASE A/C   MFPL</Option>

					<Option Value="101000334| 0 | 0" >C.I.INNOCULIN PURCHASE A/C   MFPL</Option>

					<Option Value="101000335| 0 | 0" >C.I.SCRAP PURCHASE A/C   MFPL</Option>

					<Option Value="101000336| 0 | 0" >C.R.C. SCRAP PURCHASE  A/C   MFPL</Option>

					<Option Value="101000337| 0 | 0" >CAPATIVE CON R.C.SAND   MFPL</Option>

					<Option Value="101000338| 0 | 0" >CAPATIVE CONS.SHELL-MOULD   MFPL</Option>

					<Option Value="101000006|101140073|0" >CAPITAL EXPS. OTHER BUILDING. D-11 (WIP)   DI</Option>

					<Option Value="101000006|101140090|0" >CAR - FORCE ONE SX  MH-11-BH-4110   MEPL</Option>

					<Option Value="101000006|101140003|0" >CAR INNOVA MH-11-Y-7629   MEPL</Option>

					<Option Value="101000814| 0 | 0" >CAR-CHEVROLET BEAT LTO TCDI   ME</Option>

					<Option Value="101000006|101140076|0" >CAR-CHEVROLET BEAT LTO TCDI   ME</Option>

					<Option Value="101000101| 0 | 0" >CASTING PURCHASE A/C   com</Option>

					<Option Value="101000006|101140084|0" >CENTRALISED COOLENT SYSTEM   MEPL</Option>

					<Option Value="101000339| 0 | 0" >CI NICKEL PURCHASE   MFPL</Option>

					<Option Value="101001163| 0 | 0" >CLAIM FOR NON DELIVERING OF MATERIAL   MEPL</Option>

					<Option Value="101000924| 0 | 0" >CLEARING FORWARDING CHARGES   </Option>

					<Option Value="101001173| 0 | 0" >CMM INSPECTION CHARGES (INCOME)   MEPL</Option>

					<Option Value="101000955| 0 | 0" >COMPENSATION  OF GENERATON CLAIM   MEPL</Option>

					<Option Value="101000340| 0 | 0" >COMPENSATION RECD. FROM INSURANCE   MFPL</Option>

					<Option Value="101000006|101140004|0" >COMPUTER   COM</Option>

					<Option Value="101000104| 0 | 0" >CONSULTATION FEES-TECHNICAL   com</Option>

					<Option Value="101000105| 0 | 0" >CONSUMABLE PURCHASE   com</Option>

					<Option Value="101000411| 0 | 0" >CONSUMABLE STORES   DI </Option>

					<Option Value="101000412| 0 | 0" >CONSUMABLE TOOLS   DI </Option>

					<Option Value="101000341| 0 | 0" >COPPER SCRAP PURCHASE A/C   MFPL</Option>

					<Option Value="101000109| 0 | 0" >CORE MAKING CHARGES   com</Option>

					<Option Value="101000342| 0 | 0" >CPC PUR.   MFPL</Option>

					<Option Value="101001084| 0 | 0" >CST 14% NO C FORM   MFPL</Option>

					<Option Value="101000006|101140069|0" >DEAD STOCK   DI</Option>

					<Option Value="101000695| 0 | 0" >DEEMED EXPORT   COM</Option>

					<Option Value="101000111| 0 | 0" >DEEMED EXPORT SALES   com</Option>

					<Option Value="101000978| 0 | 0" >DEPB CREDIT (BAL.)   MEPL</Option>

					<Option Value="101000992| 0 | 0" >DEPB CREDIT A/C   MEPL</Option>

					<Option Value="101000344| 0 | 0" >DEPB LICANCE   MFPL</Option>

					<Option Value="101000006|101140005|0" >DIES & FIXTURE   DI</Option>

					<Option Value="101000413| 0 | 0" >DISCOUNT RECEIVED ACCOUNT   DI </Option>

					<Option Value="101000959| 0 | 0" >DIVIDEND RECEIVED - KUB BANK LIMITED   DI</Option>

					<Option Value="101000691| 0 | 0" >DIVIDEND RECEIVED A/C   </Option>

					<Option Value="101000488| 0 | 0" >DOMESTIC PACKING   MEPL</Option>

					<Option Value="101000117| 0 | 0" >ELECTRIC INSPECTION FEES   com</Option>

					<Option Value="101001123| 0 | 0" >ELECTRICAL LINING EXPENSES   MFPL</Option>

					<Option Value="101000788| 0 | 0" >ELECTRICITY CHARGES   DI</Option>

					<Option Value="101001016| 0 | 0" >ELECTRICITY DUTY EXCEMPTION (H-21)   MEPL</Option>

					<Option Value="101001017| 0 | 0" >ELECTRICITY DUTY EXCEMPTION (H-25)   MEPL</Option>

					<Option Value="101000006|101140006|0" >ELECTRIFICATION   DI/MFPL</Option>

					<Option Value="101000006|101140081|0" >ELECTRIFICATION H-25   H21 WIP</Option>

					<Option Value="101000006|101140008|0" >ELECTRIFICATION U-1   MEPL</Option>

					<Option Value="101000006|101140009|0" >ELECTRIFICATION U-2   MEPL</Option>

					<Option Value="101000006|101140010|0" >ELECTRIFICATION WIP  (H-21)   MEPL</Option>

					<Option Value="101000006|101140011|0" >ELECTRIFICATION WIP (H-25)   MEPL</Option>

					<Option Value="101000006|101140064|0" >ERECTION  CHARGES   DI</Option>

					<Option Value="101000689| 0 | 0" >ESCORT AND OCTROI EXPENSES   </Option>

					<Option Value="101000918| 0 | 0" >ESCORT/OCTORI REFUND A/C   ME</Option>

					<Option Value="101000906| 0 | 0" >EXCISE REFUND (DRAWING & DESIGN)   ME</Option>

					<Option Value="101000692| 0 | 0" >EXCISE REFUND ACCOUNT   </Option>

					<Option Value="101000123| 0 | 0" >EXPORT- AIR FREIGHT   MEPL</Option>

					<Option Value="101000041| 0 | 0" >EXPORT SALES   COM</Option>

					<Option Value="101000490| 0 | 0" >EXPORT-CARRIAGE INWARD   MEPL</Option>

					<Option Value="101000491| 0 | 0" >EXPORT-CONSUMABLES   MEPL</Option>

					<Option Value="101000492| 0 | 0" >EXPORT-ELECTROPLATING CHARGES   MEPL</Option>

					<Option Value="101000493| 0 | 0" >EXPORT-MACHINING CHARGES   MEPL</Option>

					<Option Value="101000496| 0 | 0" >EXPORT-PACKING   MEPL</Option>

					<Option Value="101000497| 0 | 0" >EXPORT-REJECTION & REWORK   MEPL</Option>

					<Option Value="101000498| 0 | 0" >EXPORT-TOOLING   MEPL</Option>

					<Option Value="101000499| 0 | 0" >EXPORT-TRANSPORT   MEPL</Option>

					<Option Value="101000415| 0 | 0" >FACOTRY INSURANCE   DI </Option>

					<Option Value="101000006|101140013|0" >FACTORY BUILDING - WIP (H-25)   MEPL</Option>

					<Option Value="101000006|101140078|0" >FACTORY BUILDING (CF)   DI</Option>

					<Option Value="101000006|101140082|0" >FACTORY BUILDING H-25   FB H-25</Option>

					<Option Value="101000006|101140094|0" >FACTORY BUILDING H-25 PART-II   UNIT-IV (WIP)   MEPL</Option>

					<Option Value="101000350| 0 | 0" >FACTORY BUILDING REPAIRS MAINT   MFPL</Option>

					<Option Value="101000006|101140014|0" >FACTORY BUILDING U-1   MEPL/MFPL</Option>

					<Option Value="101000006|101140015|0" >FACTORY BUILDING U-2   MEPL/MFPL</Option>

					<Option Value="101000006|101140086|0" >FACTORY EQUIPMENTS   </Option>

					<Option Value="101000125| 0 | 0" >FACTORY EXPENSES   com</Option>

					<Option Value="101000126| 0 | 0" >FACTORY INSPECTION FEES   com</Option>

					<Option Value="101000127| 0 | 0" >FACTORY LICENCE FEES   com</Option>

					<Option Value="101000352| 0 | 0" >FERRO CHROMIMUM PURCHASE A/C   MFPL</Option>

					<Option Value="101000353| 0 | 0" >FERRO MANGANSE PURCHASE A/C   MFPL</Option>

					<Option Value="101000354| 0 | 0" >FERRO MOLLY PURCHASE A\C   MFPL</Option>

					<Option Value="101000355| 0 | 0" >FERRO PHOSPORUS PURCHASE A/C   MFPL</Option>

					<Option Value="101000356| 0 | 0" >FERRO SILICON MANGANSE PURCHASES A/C   MFPL</Option>

					<Option Value="101000357| 0 | 0" >FERRO SILICON PURCHASE A/C   MFPL</Option>

					<Option Value="101000131| 0 | 0" >FETTLING & PAINTING & GATE CUTTING & OTHER CHRGES   com</Option>

					<Option Value="101000971| 0 | 0" >FETTLING CHARGES   </Option>

					<Option Value="101000133| 0 | 0" >FINE RECOVERY A/C   com</Option>

					<Option Value="101000006|101140017|0" >FORKLIFT TRUCK   MEPL</Option>

					<Option Value="101000416| 0 | 0" >FOUNDRY EXPENSES   DI </Option>

					<Option Value="101000006|101140088|0" >FREEHOLD LAND-NAGEWADI TAL. & DIST.SATARA (GAT NO.291)   MEPL</Option>

					<Option Value="101000501| 0 | 0" >FREEHOLD PLOT NAIGAON KESURDI(INVESTMESNT)   MEPL</Option>

					<Option Value="101000006|101140019|0" >FREEHOLD PLOT-KESURDI NAIGAON(ASSET)   MEPL</Option>

					<Option Value="101001134| 0 | 0" >FURNACE HEAT CHARGES   MSIPL</Option>

					<Option Value="101000358| 0 | 0" >FURNACE LINING EXPENSES   MFPL</Option>

					<Option Value="101000006|101140068|0" >FURNITURE   DI</Option>

					<Option Value="101000006|101140074|0" >FURNITURE & DEAD STOCK H-25   MEPL</Option>

					<Option Value="101000006|101140021|0" >FURNITURE & DEAD STOCK U-1   MEPL</Option>

					<Option Value="101000006|101140022|0" >FURNITURE & DEAD STOCK U-2   MEPL</Option>

					<Option Value="101000359| 0 | 0" >GAS PURCHASE (SAND-RECLAMATION)   MFPL</Option>

					<Option Value="101000006|101140023|0" >GATE AND WATCHMAN CABIN   MSIPL</Option>

					<Option Value="101000973| 0 | 0" >GATE CUTTING CHARGES   </Option>

					<Option Value="101000360| 0 | 0" >HARDNER PURCHASE A/C   MFPL</Option>

					<Option Value="101001011| 0 | 0" >INCOME TAX REFUND (A.Y.2004-05)   ME</Option>

					<Option Value="101000418| 0 | 0" >INDUCTION FURNASE LINING CHARGES   DI </Option>

					<Option Value="101001096| 0 | 0" >INDUSTRIAL PROMOTION SUBSIDY (IPS) 2013-14   DI</Option>

					<Option Value="101001119| 0 | 0" >INDUSTRIAL PROMOTION SUBSIDY (IPS) 2014-15   MEPL</Option>

					<Option Value="101000939| 0 | 0" >INDUSTRIAL PROMOTION SUBSIDY (IPS) MEGA PROJECT  2011-12   MEPL</Option>

					<Option Value="101001026| 0 | 0" >INDUSTRIAL PROMOTION SUBSIDY (IPS) MEGA PROJECT  2012-13   MEPL</Option>

					<Option Value="101000936| 0 | 0" >INDUSTRIAL PROMOTION SUBSIDY-EXPANSION-PSI 2007-12   </Option>

					<Option Value="101000419| 0 | 0" >INSPECTION CHARGES   DI </Option>

					<Option Value="101000151| 0 | 0" >INSURANCE   com</Option>

					<Option Value="101000988| 0 | 0" >INSURANCE  CLAIM RECEIVED   ME</Option>

					<Option Value="101000954| 0 | 0" >INTEREST ON AXIS BANK FD   DI</Option>

					<Option Value="101001068| 0 | 0" >INTEREST ON FD SARASWAT CO-OP.BANK LTD. A/C NO.370   U-III</Option>

					<Option Value="101000524| 0 | 0" >INTEREST ON INCOME TAX REFUND   MEPL</Option>

					<Option Value="101000877| 0 | 0" >INTEREST RECEIVED ON ADVANCES   </Option>

					<Option Value="101001138| 0 | 0" >INTEREST RECEIVED ON INVESTMENT   ME</Option>

					<Option Value="101000871| 0 | 0" >INTEREST RECEIVED ON MSEB DEPOSIT   DI</Option>

					<Option Value="101001124| 0 | 0" >INTEREST RECEIVED ON RECURING DEPOSIT   MFPL</Option>

					<Option Value="101001155| 0 | 0" >INTEREST RECEIVED ON ROHA MEGACITY DEVELOPERS LLP   </Option>

					<Option Value="101001108| 0 | 0" >INTEREST RECEIVED ON WATER DEPOSIT (MIDC)   MFPL</Option>

					<Option Value="101000006|101140024|0" >JIG DIES & FIXTURE U-1   MEPL</Option>

					<Option Value="101000006|101140025|0" >JIG DIES & FIXTURE U-2   MEPL</Option>

					<Option Value="101000301| 0 | 0" >JOB WORK CHARGES   msipl</Option>

					<Option Value="101000972| 0 | 0" >KNOCKOUT CHARGES   </Option>

					<Option Value="101000006|101140063|0" >LABORATORY EQUIPMENT   MSIPL</Option>

					<Option Value="101000374| 0 | 0" >LABORATORY EXPENSES   MFPL</Option>

					<Option Value="101000709| 0 | 0" >LABOUR CHARGES A/C   </Option>

					<Option Value="101000044| 0 | 0" >LABOUR PURCHASE ACCOUNT   COM</Option>

					<Option Value="101000038| 0 | 0" >LABOUR SALES ACCOUNT   COM</Option>

					<Option Value="101000006|101140077|0" >LAND (CF)   DI</Option>

					<Option Value="101000006|101140067|0" >LAND (LEASEHOLD)   MFPL</Option>

					<Option Value="101000006|101140085|0" >LAND (WINDMILL)   MEPL</Option>

					<Option Value="101000006|101140028|0" >LEASEHOLD LAND (PLOT NO.H-21)   MEPL</Option>

					<Option Value="101000006|101140093|0" >LEASEHOLD LAND (PLOT NO.H-25) PART-II   H25</Option>

					<Option Value="101001136| 0 | 0" >LICENCE - FOCUS PRODUCT SCHEME   MEPL</Option>

					<Option Value="101001185| 0 | 0" >LICENCE - MERCHANDISE EXPORTS OF INDIA SCHEME (MEIS)   MEPL</Option>

					<Option Value="101000303| 0 | 0" >LICENCES RENEWAL FEES   msipl</Option>

					<Option Value="101000941| 0 | 0" >LICENSE (STATUS HOLDER INCENTIVE SCRIP)   MEPL</Option>

					<Option Value="101001079| 0 | 0" >LINER CUTTING CHARGES   MSIPL</Option>

					<Option Value="101000961| 0 | 0" >LOADING & UNLOADING CHARGES   ALL</Option>

					<Option Value="101001025| 0 | 0" >LOCAL BODY TAX (LBT)   MEPL</Option>

					<Option Value="101000378| 0 | 0" >M.S.ROUND BAR   MFPL</Option>

					<Option Value="101000379| 0 | 0" >M.S.SCRAP PURCHASE A/C   MFPL</Option>

					<Option Value="101000591| 0 | 0" >MACHINE SHOP EXPENSES   MEPL</Option>

					<Option Value="101000592| 0 | 0" >MACHINERY RENT PAID   MEPL</Option>

					<Option Value="101000710| 0 | 0" >MACHINING CHARGES   </Option>

					<Option Value="101000165| 0 | 0" >MACHINING/LABOUR CHARGES   com</Option>

					<Option Value="101000781| 0 | 0" >MANUFACTURING SALES RETURN   </Option>

					<Option Value="101000935| 0 | 0" >MANUFACTURING SALES RETURN SHELL MOULD   </Option>

					<Option Value="101000782| 0 | 0" >MANUFACTURING SALES RETURN-OMS   </Option>

					<Option Value="101000167| 0 | 0" >MISC.INCOME   com</Option>

					<Option Value="101000381| 0 | 0" >MOULDING CHARGES   MFPL</Option>

					<Option Value="101000384| 0 | 0" >NOTICE PAY A/C   COM</Option>

					<Option Value="101000006|101140033|0" >OFFICE BUILDING (PUNE FLAT)   MEPL</Option>

					<Option Value="101000006|101140034|0" >OFFICE BUILDING U-1   MEPL/MFPL</Option>

					<Option Value="101000006|101140035|0" >OFFICE BUILDING U-2   MEPL/MFPL</Option>

					<Option Value="101000006|101140036|0" >OFFICE EQUIPMENT   MEPL/MFPL</Option>

					<Option Value="101000934| 0 | 0" >ONE MONTH NOTICE PAYMENT   ME</Option>

					<Option Value="101000385| 0 | 0" >OTHER RAW MATERIAL   MFPL</Option>

					<Option Value="101000784| 0 | 0" >PACKING & FORWARDING-SALES   </Option>

					<Option Value="101000696| 0 | 0" >PACKING & FORWARIDNG PURCHASE   </Option>

					<Option Value="101000974| 0 | 0" >PAINTING CHARGES   </Option>

					<Option Value="101000006|101140037|0" >PATTERN   DI</Option>

					<Option Value="101000006|101140038|0" >PATTERN - JIG & DIES   MSIPL</Option>

					<Option Value="101000398| 0 | 0" >PATTERN MAINTAINCES CHARGES   COM</Option>

					<Option Value="101000772| 0 | 0" >PATTERN REPAIRS   MFPL</Option>

					<Option Value="101000312| 0 | 0" >PF DAMAGES RECOVERED   msipl</Option>

					<Option Value="101000183| 0 | 0" >PIG IRON   com</Option>

					<Option Value="101000006|101140039|0" >PLANT & MACHINERY   DI/MSIPL</Option>

					<Option Value="101000006|101140040|0" >PLANT & MACHINERY  (WIP)   DI</Option>

					<Option Value="101000006|101140072|0" >PLANT & MACHINERY (H-25) WIP   MEPL</Option>

					<Option Value="101000006|101140055|0" >PLANT & MACHINERY (WEIGHBRIDGE)   MFPL</Option>

					<Option Value="101000006|101140092|0" >PLANT & MACHINERY ERRECTION   DI</Option>

					<Option Value="101000006|101140079|0" >PLANT & MACHINERY H-25   H-21</Option>

					<Option Value="101000006|101140041|0" >PLANT & MACHINERY U-1   MEPL/MFPL</Option>

					<Option Value="101000006|101140042|0" >PLANT & MACHINERY U-2   MEPL/MFPL</Option>

					<Option Value="101000006|101140043|0" >PLANT & MACHINERY U-3   MEPL</Option>

					<Option Value="101000603| 0 | 0" >POWDER COATING CHARGES(DOMESTIC)   MEPL</Option>

					<Option Value="101000604| 0 | 0" >POWDER COATING CHARGES(EXPORT)   MEPL</Option>

					<Option Value="101000006|101140095|0" >POWDER COATING WIP   U-III</Option>

					<Option Value="101001222| 0 | 0" >POWER & ELECTRICITY CHARGES - POWDER COATING PLANT   MFPL</Option>

					<Option Value="101000874| 0 | 0" >POWER & ELECTRICITY CHARGES (H-25)   ME H25</Option>

					<Option Value="101000186| 0 | 0" >POWER & ELECTRICITY EXPENSES   com</Option>

					<Option Value="101001140| 0 | 0" >POWER CONSULTANCY CHARGES   DI/MFPL</Option>

					<Option Value="101000609| 0 | 0" >PROFIT ON SALE OF  FREEHOLD LAND-KHINDWADI   MEPL</Option>

					<Option Value="101000779| 0 | 0" >PROFIT ON SALE OF DEPB LICENCE   MEPL</Option>

					<Option Value="101001152| 0 | 0" >PROFIT ON SALE OF FIXTURE   MEPL</Option>

					<Option Value="101001194| 0 | 0" >PROFIT ON SALE OF INNOVA CAR (MH-11-Y-7629)   MEPL</Option>

					<Option Value="101000195| 0 | 0" >PROFIT ON SALE OF MACHINERY   com</Option>

					<Option Value="101000196| 0 | 0" >PROFIT ON SALE OF RELIANCE GROWTH FUND (D)   com</Option>

					<Option Value="101000884| 0 | 0" >PROFIT ON SALE OF SCRAP CAR MH-18 B - 875   </Option>

					<Option Value="101000197| 0 | 0" >PROFIT ON SALE OF SHARES   com</Option>

					<Option Value="101000866| 0 | 0" >PROVISION FOR RATE AMENDMENT   </Option>

					<Option Value="101001174| 0 | 0" >PROVISION FOR RATE REDUCTION   </Option>

					<Option Value="101000433| 0 | 0" >PUR S.G CRC SCRAP   DI </Option>

					<Option Value="101000434| 0 | 0" >PUR. C.I.SCRAP   DI </Option>

					<Option Value="101000435| 0 | 0" >PUR.ALUMINIUM SCRAP   DI </Option>

					<Option Value="101000436| 0 | 0" >PUR.C.I.BOARING   DI </Option>

					<Option Value="101000437| 0 | 0" >PUR.C.I.CASTINGS   DI </Option>

					<Option Value="101000438| 0 | 0" >PUR.COKE   DI </Option>

					<Option Value="101000611| 0 | 0" >PUR.CONS.STORES   MEPL</Option>

					<Option Value="101000612| 0 | 0" >PUR.CONS.TOOLS   MEPL</Option>

					<Option Value="101000439| 0 | 0" >PUR.M.S.SCRAP   DI </Option>

					<Option Value="101000440| 0 | 0" >PUR.OTHER RAW MATERIAL   DI </Option>

					<Option Value="101000441| 0 | 0" >PUR.PIG IRON   DI </Option>

					<Option Value="101000442| 0 | 0" >PUR:-M.S.ROUND BAR   DI </Option>

					<Option Value="101000613| 0 | 0" >PURCHASE (CI+SGI) CASTINGS   MEPL</Option>

					<Option Value="101000614| 0 | 0" >PURCHASE CI SCRAP   MEPL</Option>

					<Option Value="101001000| 0 | 0" >PURCHASE CI/SGI CASTINGS H-25   H25</Option>

					<Option Value="101000615| 0 | 0" >PURCHASE EXPORT CASTING (SGI+CI)   MEPL</Option>

					<Option Value="101000723| 0 | 0" >PURCHASE OF ALUMN.CASTINGS (DOM+EXPORT)   </Option>

					<Option Value="101000387| 0 | 0" >PURCHASE OF CONSUMABLE STORES   MFPL</Option>

					<Option Value="101001081| 0 | 0" >PURCHASE RETURN   </Option>

					<Option Value="101000764| 0 | 0" >PURCHASE RETURN - ALUMN.CASTINGS -DOMESTIC    MEPL</Option>

					<Option Value="101001001| 0 | 0" >PURCHASE RETURN - CI/SGI CASTINGS H-25    H25</Option>

					<Option Value="101000762| 0 | 0" >PURCHASE RETURN - CI/SGI CASTINGS-DOMESTIC    MEPL</Option>

					<Option Value="101000763| 0 | 0" >PURCHASE RETURN - S.G.I CASTINGS-EXPORT    MEPL</Option>

					<Option Value="101000688| 0 | 0" >PURCHASE S G I CASTING   MSIPL</Option>

					<Option Value="101000616| 0 | 0" >PURCHASE SGI SCRAP   MEPL</Option>

					<Option Value="101000443| 0 | 0" >PURCHASE SHELL MOULD (CORE MAKING)   DI </Option>

					<Option Value="101001099| 0 | 0" >PURCHASE TIN INGOT   DI</Option>

					<Option Value="101000444| 0 | 0" >PURCHASE-C.P.COKE   DI </Option>

					<Option Value="101000314| 0 | 0" >QUALITY CONTROL EXPS   msipl</Option>

					<Option Value="101000315| 0 | 0" >R.M. (OTHER)   msipl</Option>

					<Option Value="101000915| 0 | 0" >RATE DIFFERANCE   </Option>

					<Option Value="101000970| 0 | 0" >RATE DIFFERANCE OMS   </Option>

					<Option Value="101000316| 0 | 0" >RAW MATERIAL PURCHASE   msipl</Option>

					<Option Value="101000388| 0 | 0" >RAW SILICA SAND PURCHASE A/C   MFPL</Option>

					<Option Value="101000943| 0 | 0" >RAW SILICA SAND RECLAIMED PURCHASE   </Option>

					<Option Value="101001007| 0 | 0" >REC TRADE  INCOME (INDIAN ENERGY EXCHANGE)   ME</Option>

					<Option Value="101000914| 0 | 0" >REJECTION CHARGES   </Option>

					<Option Value="101000445| 0 | 0" >REJECTION INWORD EXPENSES   DI </Option>

					<Option Value="101001220| 0 | 0" >RENT FOR POWDER COATING PLANT   MFPL</Option>

					<Option Value="101000622| 0 | 0" >RENTING OF IMMOVIABLE PROPERTY-CORP.OFFICE   MEPL</Option>

					<Option Value="101000045| 0 | 0" >REPAIR SALES ACCOUNT   COM</Option>

					<Option Value="101000209| 0 | 0" >REPAIRS & MAINTAINANCE-MACHINERY   com</Option>

					<Option Value="101000389| 0 | 0" >RESIN COATED SAND PURCHASE A/C   MFPL</Option>

					<Option Value="101000390| 0 | 0" >RESIN LIQUID PURCHASE A/C   MFPL</Option>

					<Option Value="101001013| 0 | 0" >REWORK CHARGES - DOMESTIC   ME</Option>

					<Option Value="101000009| 0 | 0" >ROUNDING OFF ACCOUNT   erp a/c</Option>

					<Option Value="101000780| 0 | 0" >SALE ALUMINIUM  BORING   MEPL</Option>

					<Option Value="101001040| 0 | 0" >SALE ALUMINIUM  SCRAP   MEPL</Option>

					<Option Value="101000767| 0 | 0" >SALE ALUMN..MACH.CASTINGS -SALES RETURN   MEPL</Option>

					<Option Value="101000786| 0 | 0" >SALE ALUMN.CASTING OMS 2%   DI</Option>

					<Option Value="101000624| 0 | 0" >SALE C.I.BOARING   MEPL</Option>

					<Option Value="101000948| 0 | 0" >SALE C.I.BOARING SALES RETURN   ME</Option>

					<Option Value="101000785| 0 | 0" >SALE C.I.CASTINGS OMS 2%   DI</Option>

					<Option Value="101000776| 0 | 0" >SALE C.I.MACH.CASTINGS -OMS 2%   MEPL</Option>

					<Option Value="101000766| 0 | 0" >SALE C.I.MACH.CASTINGS -SALES RETURN   MEPL</Option>

					<Option Value="101001207| 0 | 0" >SALE CASTINGS EXPORT  (U-III)   MSIPL</Option>

					<Option Value="101000998| 0 | 0" >SALE CI/SGI CASTINGS    H-25   H25</Option>

					<Option Value="101000999| 0 | 0" >SALE CI/SGI CASTINGS - SALES RETURN H-25   H25</Option>

					<Option Value="101000996| 0 | 0" >SALE CI/SGI MACHINED CASTING  H-25   H25</Option>

					<Option Value="101000997| 0 | 0" >SALE CI/SGI MACHINED CASTING - SALE RETURN  H25   H25</Option>

					<Option Value="101000789| 0 | 0" >SALE- CORES & MOULD   </Option>

					<Option Value="101000951| 0 | 0" >SALE MACH.CASTINGS EXPORT-SALE RETURN   ME</Option>

					<Option Value="101000777| 0 | 0" >SALE MACH.CASTINGS -OMS2% SALES RETURN   MEPL</Option>

					<Option Value="101001070| 0 | 0" >SALE MACHINING DEFECTIVES- REJECTION   MEPL</Option>

					<Option Value="101000950| 0 | 0" >SALE MACHINING/LABOUR CHARGES SALE RETURN   ME</Option>

					<Option Value="101000797| 0 | 0" >SALE MOULDING BOX   DI</Option>

					<Option Value="101000625| 0 | 0" >SALE OF DEPB LICENCE   MEPL</Option>

					<Option Value="101000980| 0 | 0" >SALE OF WIND POWER ELECTRICITY   MEPL</Option>

					<Option Value="101000790| 0 | 0" >SALE OTHER   DI</Option>

					<Option Value="101000833| 0 | 0" >SALE PIG IRON   DI</Option>

					<Option Value="101000765| 0 | 0" >SALE PURCHASE (REJ.) ALUMN.CASTINGS -EXPORT   MEPL</Option>

					<Option Value="101001075| 0 | 0" >SALE RATE REDUCTION ALUMN.CASTINGS   DI</Option>

					<Option Value="101001074| 0 | 0" >SALE RATE REDUCTION C.I.CASTINGS   DI</Option>

					<Option Value="101000931| 0 | 0" >SALE RATE REDUCTION -DOMESTIC   MEPL</Option>

					<Option Value="101001209| 0 | 0" >SALE RATE REDUCTION -DOMESTIC H-25   MEPL II</Option>

					<Option Value="101000933| 0 | 0" >SALE RATE REDUCTION -EXPORT   MEPL</Option>

					<Option Value="101000932| 0 | 0" >SALE RATE REDUCTION OMS 2%   ME</Option>

					<Option Value="101000944| 0 | 0" >SALE RAW SILICA SAND RECLAIMED   </Option>

					<Option Value="101000949| 0 | 0" >SALE S.G.I.BOARING SALE RETURN   MEPL</Option>

					<Option Value="101000629| 0 | 0" >SALE-AIR FREIGHT-(INCOME)   MEPL</Option>

					<Option Value="101000630| 0 | 0" >SALE-MACHINED CASTINGS-DOMESTIC   MEPL</Option>

					<Option Value="101000631| 0 | 0" >SALE-MACHINED CASTINGS-EXPORT   MEPL</Option>

					<Option Value="101000773| 0 | 0" >SALE-MACHINING/LABOUR CHARGES   </Option>

					<Option Value="101000632| 0 | 0" >SALE-PLANT &MACHINERY U3   MEPL</Option>

					<Option Value="101000392| 0 | 0" >SALES - EXPORT   MFPL</Option>

					<Option Value="101000633| 0 | 0" >SALES - TOOL COST   MEPL</Option>

					<Option Value="101001218| 0 | 0" >SALES - TOOLS COST EXPORT   MEPL</Option>

					<Option Value="101000447| 0 | 0" >SALES ALUMN.CASTINGS   DI </Option>

					<Option Value="101001172| 0 | 0" >SALES ALUMN.CASTINGS - SALES RETURN   DI</Option>

					<Option Value="101000774| 0 | 0" >SALES ALUMN.CASTINGS (DOMESTIC)   </Option>

					<Option Value="101000775| 0 | 0" >SALES ALUMN.CASTINGS (EXPORT)   </Option>

					<Option Value="101001082| 0 | 0" >SALES ALUMN.CASTINGS (OMS 2%)   ME</Option>

					<Option Value="101001083| 0 | 0" >SALES ALUMN.CASTINGS (OMS 2%) SALES RETURN   ME</Option>

					<Option Value="101000448| 0 | 0" >SALES C.I.CASTINGS   COM</Option>

					<Option Value="101001170| 0 | 0" >SALES C.I.CASTINGS - SALES RETURN   DI</Option>

					<Option Value="101001171| 0 | 0" >SALES C.I.CASTINGS OMS 2% - SALES RETURN   DI</Option>

					<Option Value="101000634| 0 | 0" >SALES C.I.SCRAP   MEPL</Option>

					<Option Value="101001085| 0 | 0" >SALES CAS 4   </Option>

					<Option Value="101000783| 0 | 0" >SALES CASTING -OMS   </Option>

					<Option Value="101001010| 0 | 0" >SALES COMPUTER   </Option>

					<Option Value="101000891| 0 | 0" >SALES CONSUMABLE MATERIAL   MSIPL</Option>

					<Option Value="101000865| 0 | 0" >SALES CREDIT NOTE ACCOUNTS ONLY   MSIPL</Option>

					<Option Value="101001169| 0 | 0" >SALES CREDIT NOTE ACCOUNTS ONLY - OMS   MSIPL</Option>

					<Option Value="101000460| 0 | 0" >SALES OF DEPB LICENCE   MEPL/DI</Option>

					<Option Value="101000451| 0 | 0" >SALES- PLANT & MACHINERY   DI </Option>

					<Option Value="101000394| 0 | 0" >SALES R.C. SAND   MFPL</Option>

					<Option Value="101000890| 0 | 0" >SALES RAW MATERIAL   MSIPL</Option>

					<Option Value="101000319| 0 | 0" >SALES S. G. IRON CASTINGS   COM</Option>

					<Option Value="101000864| 0 | 0" >SALES S. G. IRON CASTINGS- OMS   MSIPL</Option>

					<Option Value="101000638| 0 | 0" >SALES S.G.I. SCRAP   MEPL</Option>

					<Option Value="101000639| 0 | 0" >SALES S.G.I.BOARING   MEPL</Option>

					<Option Value="101000395| 0 | 0" >SALES SHELL MOULD   MFPL</Option>

					<Option Value="101001077| 0 | 0" >SALES TAX REFUND 2005-06   MEPL</Option>

					<Option Value="101000456| 0 | 0" >SALES-C. I. BOARING   DI </Option>

					<Option Value="101000641| 0 | 0" >SALES-MACHINING CHARGES   MEPL</Option>

					<Option Value="101000642| 0 | 0" >SALES-TOOL/DRILL/TAPS (SCRAP)   MEPL</Option>

					<Option Value="101001071| 0 | 0" >SALES-TOOLS & EQUIPMENTS   MFPL</Option>

					<Option Value="101000947| 0 | 0" >SCHEDULE ADHELS PENALTY   ME</Option>

					<Option Value="101000822| 0 | 0" >SCHEME OF DUTY DRAWBACK RECEIPT   MEPL</Option>

					<Option Value="101000039| 0 | 0" >SCRAP SALES   COM</Option>

					<Option Value="101000215| 0 | 0" >SECURITY EXPENSES   com</Option>

					<Option Value="101000938| 0 | 0" >SEGREGATION & REWORK CHARGES   </Option>

					<Option Value="101000321| 0 | 0" >SHOTBLASTING EXPS   msipl</Option>

					<Option Value="101000322| 0 | 0" >SPECTRO TESTING  CHARGES   msipl</Option>

					<Option Value="101001135| 0 | 0" >SPILLAGE COLLECTION CHARGES   MSIPL</Option>

					<Option Value="101001100| 0 | 0" >SUNDRY DEBTORS SETTLEMENT ACCOUNT   MEPL </Option>

					<Option Value="101001101| 0 | 0" >SUNDRY DEBTORS SETTLMENT A/C   MEPL</Option>

					<Option Value="101000403| 0 | 0" >TIN PURCHASE A/C   MFPL</Option>

					<Option Value="101000006|101140066|0" >TOOLS & EQUIPMENT   MFPL</Option>

					<Option Value="101000006|101140045|0" >TOOLS & EQUIPMENT U-1   MEPL</Option>

					<Option Value="101000006|101140046|0" >TOOLS & EQUIPMENT U-2   MEPL</Option>

					<Option Value="101000989| 0 | 0" >TOOLS GRINDING/RESHARPNING CHARGES-DOMESTIC   ME</Option>

					<Option Value="101000990| 0 | 0" >TOOLS GRINDING/RESHARPNING CHARGES-EXPORT   ME</Option>

					<Option Value="101000006|101140080|0" >TRACTOR TRAILOR RED (TROLLEY)   MEPL</Option>

					<Option Value="101000099| 0 | 0" >TRANSPORT  CHARGES (INWARD)   com</Option>

					<Option Value="101000242| 0 | 0" >TRANSPORT CHARGES (OUTWARD)   com</Option>

					<Option Value="101000461| 0 | 0" >TRANSPORT CHARGES (SALES)   DI </Option>

					<Option Value="101000243| 0 | 0" >TRANSPORT CHARGES LOCAL   com</Option>

					<Option Value="101000006|101140047|0" >TYPE WRITER   MEPL</Option>

					<Option Value="101000981| 0 | 0" >VALUE OF UNITS GENERATED-WTG   MEPL</Option>

					<Option Value="101001012| 0 | 0" >VANEDIUM PURCHASE   </Option>

					<Option Value="101001131| 0 | 0" >VAT REFUND 2010-11   DI</Option>

					<Option Value="101000006|101140091|0" >VEHICLE - FORD ECO SPORTS   DI</Option>

					<Option Value="101000006|101140097|0" >VEHICLE - INNOVA CRYSTA MH-11-BV-7022   DI</Option>

					<Option Value="101000667| 0 | 0" >VENDOR MACHINE SHOP EXPS.   MEPL</Option>

					<Option Value="101000251| 0 | 0" >WATER CHARGES   com</Option>

					<Option Value="101001221| 0 | 0" >WATER CHARGES - POWDER COATING PLANT   MFPL</Option>

					<Option Value="101000875| 0 | 0" >WATER CHARGES (H-25)   MEPL</Option>

					<Option Value="101000253| 0 | 0" >WEIGHMENT CHARGES   com</Option>

					<Option Value="101000929| 0 | 0" >WIND ENERGY CHARGES RECEIVED FROM MSEDCL   MEPL</Option>

					<Option Value="101000006|101140083|0" >WINDMILL   MEPL</Option>

					<Option Value="101000006|101140089|0" >WIP LINER PROJECT   </Option>

					<Option Value="101000006|101140096|0" >WIP PLANT & MACHINERY (POWDER COATING PLANT)   MFPL</Option>

					<Option Value="101000006|101140075|0" >WIP PLANT AND MACHINARY   MSIPL</Option>

					<Option Value="101000006|101140065|0" >WIP VINAR & PAINT SHOP PROJECT   MFPL</Option>

					<Option Value="101000006|101140070|0" >WORKS EQUIPMENTS   DI</Option>

				</select>
			</td>
		</tr>
		<tr>
			<td width="05%" colspan="05" align="left"> &nbsp</td>
			<td Width="25%" colspan="25" align="left">
				<label class="caption" >Sales Return</label>
			</td>
			<Td Width="70%" colspan="70" align="left">
				<Select id="drpSaleRetAcno" name="drpSaleRetAcno"  TabIndex="30" >
					<Option Value="0">&nbsp;</Option>
					
						<Option Value="101000255| 0 | 0" >ANNEALING  CHARGES   msipl</Option>

						<Option Value="101000040| 0 | 0" >APPRICIATION VALUE OF SHARE   MEPL</Option>

						<Option Value="101000006|101140071|0" >AUTO TRUCK TRIALOR   DI</Option>

						<Option Value="101000086| 0 | 0" >BANK DIVIDEND   com</Option>

						<Option Value="101000089| 0 | 0" >BILL DISCOUNTING CHARGES RECEIVED   com</Option>

						<Option Value="101000993| 0 | 0" >BOUGHTOUT ITEM FOR FORCE MOTORS -RAW MATERIAL   MEPL</Option>

						<Option Value="101000957| 0 | 0" >BOUGHTOUT ITEM FOR JCB -RAW MATERIAL   ME</Option>

						<Option Value="101001186| 0 | 0" >BOUGHTOUT ITEM FOR -TACO ASSEMBLY   MEPL</Option>

						<Option Value="101000975| 0 | 0" >BOX TRANSFER CHARGES   </Option>

						<Option Value="101000333| 0 | 0" >C.I.BOARING PURCHASE A/C   MFPL</Option>

						<Option Value="101000334| 0 | 0" >C.I.INNOCULIN PURCHASE A/C   MFPL</Option>

						<Option Value="101000335| 0 | 0" >C.I.SCRAP PURCHASE A/C   MFPL</Option>

						<Option Value="101000336| 0 | 0" >C.R.C. SCRAP PURCHASE  A/C   MFPL</Option>

						<Option Value="101000337| 0 | 0" >CAPATIVE CON R.C.SAND   MFPL</Option>

						<Option Value="101000338| 0 | 0" >CAPATIVE CONS.SHELL-MOULD   MFPL</Option>

						<Option Value="101000006|101140073|0" >CAPITAL EXPS. OTHER BUILDING. D-11 (WIP)   DI</Option>

						<Option Value="101000006|101140090|0" >CAR - FORCE ONE SX  MH-11-BH-4110   MEPL</Option>

						<Option Value="101000006|101140003|0" >CAR INNOVA MH-11-Y-7629   MEPL</Option>

						<Option Value="101000814| 0 | 0" >CAR-CHEVROLET BEAT LTO TCDI   ME</Option>

						<Option Value="101000006|101140076|0" >CAR-CHEVROLET BEAT LTO TCDI   ME</Option>

						<Option Value="101000101| 0 | 0" >CASTING PURCHASE A/C   com</Option>

						<Option Value="101000006|101140084|0" >CENTRALISED COOLENT SYSTEM   MEPL</Option>

						<Option Value="101000339| 0 | 0" >CI NICKEL PURCHASE   MFPL</Option>

						<Option Value="101001163| 0 | 0" >CLAIM FOR NON DELIVERING OF MATERIAL   MEPL</Option>

						<Option Value="101000924| 0 | 0" >CLEARING FORWARDING CHARGES   </Option>

						<Option Value="101001173| 0 | 0" >CMM INSPECTION CHARGES (INCOME)   MEPL</Option>

						<Option Value="101000955| 0 | 0" >COMPENSATION  OF GENERATON CLAIM   MEPL</Option>

						<Option Value="101000340| 0 | 0" >COMPENSATION RECD. FROM INSURANCE   MFPL</Option>

						<Option Value="101000006|101140004|0" >COMPUTER   COM</Option>

						<Option Value="101000104| 0 | 0" >CONSULTATION FEES-TECHNICAL   com</Option>

						<Option Value="101000105| 0 | 0" >CONSUMABLE PURCHASE   com</Option>

						<Option Value="101000411| 0 | 0" >CONSUMABLE STORES   DI </Option>

						<Option Value="101000412| 0 | 0" >CONSUMABLE TOOLS   DI </Option>

						<Option Value="101000341| 0 | 0" >COPPER SCRAP PURCHASE A/C   MFPL</Option>

						<Option Value="101000109| 0 | 0" >CORE MAKING CHARGES   com</Option>

						<Option Value="101000342| 0 | 0" >CPC PUR.   MFPL</Option>

						<Option Value="101001084| 0 | 0" >CST 14% NO C FORM   MFPL</Option>

						<Option Value="101000006|101140069|0" >DEAD STOCK   DI</Option>

						<Option Value="101000695| 0 | 0" >DEEMED EXPORT   COM</Option>

						<Option Value="101000111| 0 | 0" >DEEMED EXPORT SALES   com</Option>

						<Option Value="101000978| 0 | 0" >DEPB CREDIT (BAL.)   MEPL</Option>

						<Option Value="101000992| 0 | 0" >DEPB CREDIT A/C   MEPL</Option>

						<Option Value="101000344| 0 | 0" >DEPB LICANCE   MFPL</Option>

						<Option Value="101000006|101140005|0" >DIES & FIXTURE   DI</Option>

						<Option Value="101000413| 0 | 0" >DISCOUNT RECEIVED ACCOUNT   DI </Option>

						<Option Value="101000959| 0 | 0" >DIVIDEND RECEIVED - KUB BANK LIMITED   DI</Option>

						<Option Value="101000691| 0 | 0" >DIVIDEND RECEIVED A/C   </Option>

						<Option Value="101000488| 0 | 0" >DOMESTIC PACKING   MEPL</Option>

						<Option Value="101000117| 0 | 0" >ELECTRIC INSPECTION FEES   com</Option>

						<Option Value="101001123| 0 | 0" >ELECTRICAL LINING EXPENSES   MFPL</Option>

						<Option Value="101000788| 0 | 0" >ELECTRICITY CHARGES   DI</Option>

						<Option Value="101001016| 0 | 0" >ELECTRICITY DUTY EXCEMPTION (H-21)   MEPL</Option>

						<Option Value="101001017| 0 | 0" >ELECTRICITY DUTY EXCEMPTION (H-25)   MEPL</Option>

						<Option Value="101000006|101140006|0" >ELECTRIFICATION   DI/MFPL</Option>

						<Option Value="101000006|101140081|0" >ELECTRIFICATION H-25   H21 WIP</Option>

						<Option Value="101000006|101140008|0" >ELECTRIFICATION U-1   MEPL</Option>

						<Option Value="101000006|101140009|0" >ELECTRIFICATION U-2   MEPL</Option>

						<Option Value="101000006|101140010|0" >ELECTRIFICATION WIP  (H-21)   MEPL</Option>

						<Option Value="101000006|101140011|0" >ELECTRIFICATION WIP (H-25)   MEPL</Option>

						<Option Value="101000006|101140064|0" >ERECTION  CHARGES   DI</Option>

						<Option Value="101000689| 0 | 0" >ESCORT AND OCTROI EXPENSES   </Option>

						<Option Value="101000918| 0 | 0" >ESCORT/OCTORI REFUND A/C   ME</Option>

						<Option Value="101000906| 0 | 0" >EXCISE REFUND (DRAWING & DESIGN)   ME</Option>

						<Option Value="101000692| 0 | 0" >EXCISE REFUND ACCOUNT   </Option>

						<Option Value="101000123| 0 | 0" >EXPORT- AIR FREIGHT   MEPL</Option>

						<Option Value="101000041| 0 | 0" >EXPORT SALES   COM</Option>

						<Option Value="101000490| 0 | 0" >EXPORT-CARRIAGE INWARD   MEPL</Option>

						<Option Value="101000491| 0 | 0" >EXPORT-CONSUMABLES   MEPL</Option>

						<Option Value="101000492| 0 | 0" >EXPORT-ELECTROPLATING CHARGES   MEPL</Option>

						<Option Value="101000493| 0 | 0" >EXPORT-MACHINING CHARGES   MEPL</Option>

						<Option Value="101000496| 0 | 0" >EXPORT-PACKING   MEPL</Option>

						<Option Value="101000497| 0 | 0" >EXPORT-REJECTION & REWORK   MEPL</Option>

						<Option Value="101000498| 0 | 0" >EXPORT-TOOLING   MEPL</Option>

						<Option Value="101000499| 0 | 0" >EXPORT-TRANSPORT   MEPL</Option>

						<Option Value="101000415| 0 | 0" >FACOTRY INSURANCE   DI </Option>

						<Option Value="101000006|101140013|0" >FACTORY BUILDING - WIP (H-25)   MEPL</Option>

						<Option Value="101000006|101140078|0" >FACTORY BUILDING (CF)   DI</Option>

						<Option Value="101000006|101140082|0" >FACTORY BUILDING H-25   FB H-25</Option>

						<Option Value="101000006|101140094|0" >FACTORY BUILDING H-25 PART-II   UNIT-IV (WIP)   MEPL</Option>

						<Option Value="101000350| 0 | 0" >FACTORY BUILDING REPAIRS MAINT   MFPL</Option>

						<Option Value="101000006|101140014|0" >FACTORY BUILDING U-1   MEPL/MFPL</Option>

						<Option Value="101000006|101140015|0" >FACTORY BUILDING U-2   MEPL/MFPL</Option>

						<Option Value="101000006|101140086|0" >FACTORY EQUIPMENTS   </Option>

						<Option Value="101000125| 0 | 0" >FACTORY EXPENSES   com</Option>

						<Option Value="101000126| 0 | 0" >FACTORY INSPECTION FEES   com</Option>

						<Option Value="101000127| 0 | 0" >FACTORY LICENCE FEES   com</Option>

						<Option Value="101000352| 0 | 0" >FERRO CHROMIMUM PURCHASE A/C   MFPL</Option>

						<Option Value="101000353| 0 | 0" >FERRO MANGANSE PURCHASE A/C   MFPL</Option>

						<Option Value="101000354| 0 | 0" >FERRO MOLLY PURCHASE A\C   MFPL</Option>

						<Option Value="101000355| 0 | 0" >FERRO PHOSPORUS PURCHASE A/C   MFPL</Option>

						<Option Value="101000356| 0 | 0" >FERRO SILICON MANGANSE PURCHASES A/C   MFPL</Option>

						<Option Value="101000357| 0 | 0" >FERRO SILICON PURCHASE A/C   MFPL</Option>

						<Option Value="101000131| 0 | 0" >FETTLING & PAINTING & GATE CUTTING & OTHER CHRGES   com</Option>

						<Option Value="101000971| 0 | 0" >FETTLING CHARGES   </Option>

						<Option Value="101000133| 0 | 0" >FINE RECOVERY A/C   com</Option>

						<Option Value="101000006|101140017|0" >FORKLIFT TRUCK   MEPL</Option>

						<Option Value="101000416| 0 | 0" >FOUNDRY EXPENSES   DI </Option>

						<Option Value="101000006|101140088|0" >FREEHOLD LAND-NAGEWADI TAL. & DIST.SATARA (GAT NO.291)   MEPL</Option>

						<Option Value="101000501| 0 | 0" >FREEHOLD PLOT NAIGAON KESURDI(INVESTMESNT)   MEPL</Option>

						<Option Value="101000006|101140019|0" >FREEHOLD PLOT-KESURDI NAIGAON(ASSET)   MEPL</Option>

						<Option Value="101001134| 0 | 0" >FURNACE HEAT CHARGES   MSIPL</Option>

						<Option Value="101000358| 0 | 0" >FURNACE LINING EXPENSES   MFPL</Option>

						<Option Value="101000006|101140068|0" >FURNITURE   DI</Option>

						<Option Value="101000006|101140074|0" >FURNITURE & DEAD STOCK H-25   MEPL</Option>

						<Option Value="101000006|101140021|0" >FURNITURE & DEAD STOCK U-1   MEPL</Option>

						<Option Value="101000006|101140022|0" >FURNITURE & DEAD STOCK U-2   MEPL</Option>

						<Option Value="101000359| 0 | 0" >GAS PURCHASE (SAND-RECLAMATION)   MFPL</Option>

						<Option Value="101000006|101140023|0" >GATE AND WATCHMAN CABIN   MSIPL</Option>

						<Option Value="101000973| 0 | 0" >GATE CUTTING CHARGES   </Option>

						<Option Value="101000360| 0 | 0" >HARDNER PURCHASE A/C   MFPL</Option>

						<Option Value="101001011| 0 | 0" >INCOME TAX REFUND (A.Y.2004-05)   ME</Option>

						<Option Value="101000418| 0 | 0" >INDUCTION FURNASE LINING CHARGES   DI </Option>

						<Option Value="101001096| 0 | 0" >INDUSTRIAL PROMOTION SUBSIDY (IPS) 2013-14   DI</Option>

						<Option Value="101001119| 0 | 0" >INDUSTRIAL PROMOTION SUBSIDY (IPS) 2014-15   MEPL</Option>

						<Option Value="101000939| 0 | 0" >INDUSTRIAL PROMOTION SUBSIDY (IPS) MEGA PROJECT  2011-12   MEPL</Option>

						<Option Value="101001026| 0 | 0" >INDUSTRIAL PROMOTION SUBSIDY (IPS) MEGA PROJECT  2012-13   MEPL</Option>

						<Option Value="101000936| 0 | 0" >INDUSTRIAL PROMOTION SUBSIDY-EXPANSION-PSI 2007-12   </Option>

						<Option Value="101000419| 0 | 0" >INSPECTION CHARGES   DI </Option>

						<Option Value="101000151| 0 | 0" >INSURANCE   com</Option>

						<Option Value="101000988| 0 | 0" >INSURANCE  CLAIM RECEIVED   ME</Option>

						<Option Value="101000954| 0 | 0" >INTEREST ON AXIS BANK FD   DI</Option>

						<Option Value="101001068| 0 | 0" >INTEREST ON FD SARASWAT CO-OP.BANK LTD. A/C NO.370   U-III</Option>

						<Option Value="101000524| 0 | 0" >INTEREST ON INCOME TAX REFUND   MEPL</Option>

						<Option Value="101000877| 0 | 0" >INTEREST RECEIVED ON ADVANCES   </Option>

						<Option Value="101001138| 0 | 0" >INTEREST RECEIVED ON INVESTMENT   ME</Option>

						<Option Value="101000871| 0 | 0" >INTEREST RECEIVED ON MSEB DEPOSIT   DI</Option>

						<Option Value="101001124| 0 | 0" >INTEREST RECEIVED ON RECURING DEPOSIT   MFPL</Option>

						<Option Value="101001155| 0 | 0" >INTEREST RECEIVED ON ROHA MEGACITY DEVELOPERS LLP   </Option>

						<Option Value="101001108| 0 | 0" >INTEREST RECEIVED ON WATER DEPOSIT (MIDC)   MFPL</Option>

						<Option Value="101000006|101140024|0" >JIG DIES & FIXTURE U-1   MEPL</Option>

						<Option Value="101000006|101140025|0" >JIG DIES & FIXTURE U-2   MEPL</Option>

						<Option Value="101000301| 0 | 0" >JOB WORK CHARGES   msipl</Option>

						<Option Value="101000972| 0 | 0" >KNOCKOUT CHARGES   </Option>

						<Option Value="101000006|101140063|0" >LABORATORY EQUIPMENT   MSIPL</Option>

						<Option Value="101000374| 0 | 0" >LABORATORY EXPENSES   MFPL</Option>

						<Option Value="101000709| 0 | 0" >LABOUR CHARGES A/C   </Option>

						<Option Value="101000044| 0 | 0" >LABOUR PURCHASE ACCOUNT   COM</Option>

						<Option Value="101000038| 0 | 0" >LABOUR SALES ACCOUNT   COM</Option>

						<Option Value="101000006|101140077|0" >LAND (CF)   DI</Option>

						<Option Value="101000006|101140067|0" >LAND (LEASEHOLD)   MFPL</Option>

						<Option Value="101000006|101140085|0" >LAND (WINDMILL)   MEPL</Option>

						<Option Value="101000006|101140028|0" >LEASEHOLD LAND (PLOT NO.H-21)   MEPL</Option>

						<Option Value="101000006|101140093|0" >LEASEHOLD LAND (PLOT NO.H-25) PART-II   H25</Option>

						<Option Value="101001136| 0 | 0" >LICENCE - FOCUS PRODUCT SCHEME   MEPL</Option>

						<Option Value="101001185| 0 | 0" >LICENCE - MERCHANDISE EXPORTS OF INDIA SCHEME (MEIS)   MEPL</Option>

						<Option Value="101000303| 0 | 0" >LICENCES RENEWAL FEES   msipl</Option>

						<Option Value="101000941| 0 | 0" >LICENSE (STATUS HOLDER INCENTIVE SCRIP)   MEPL</Option>

						<Option Value="101001079| 0 | 0" >LINER CUTTING CHARGES   MSIPL</Option>

						<Option Value="101000961| 0 | 0" >LOADING & UNLOADING CHARGES   ALL</Option>

						<Option Value="101001025| 0 | 0" >LOCAL BODY TAX (LBT)   MEPL</Option>

						<Option Value="101000378| 0 | 0" >M.S.ROUND BAR   MFPL</Option>

						<Option Value="101000379| 0 | 0" >M.S.SCRAP PURCHASE A/C   MFPL</Option>

						<Option Value="101000591| 0 | 0" >MACHINE SHOP EXPENSES   MEPL</Option>

						<Option Value="101000592| 0 | 0" >MACHINERY RENT PAID   MEPL</Option>

						<Option Value="101000710| 0 | 0" >MACHINING CHARGES   </Option>

						<Option Value="101000165| 0 | 0" >MACHINING/LABOUR CHARGES   com</Option>

						<Option Value="101000781| 0 | 0" >MANUFACTURING SALES RETURN   </Option>

						<Option Value="101000935| 0 | 0" >MANUFACTURING SALES RETURN SHELL MOULD   </Option>

						<Option Value="101000782| 0 | 0" >MANUFACTURING SALES RETURN-OMS   </Option>

						<Option Value="101000167| 0 | 0" >MISC.INCOME   com</Option>

						<Option Value="101000381| 0 | 0" >MOULDING CHARGES   MFPL</Option>

						<Option Value="101000384| 0 | 0" >NOTICE PAY A/C   COM</Option>

						<Option Value="101000006|101140033|0" >OFFICE BUILDING (PUNE FLAT)   MEPL</Option>

						<Option Value="101000006|101140034|0" >OFFICE BUILDING U-1   MEPL/MFPL</Option>

						<Option Value="101000006|101140035|0" >OFFICE BUILDING U-2   MEPL/MFPL</Option>

						<Option Value="101000006|101140036|0" >OFFICE EQUIPMENT   MEPL/MFPL</Option>

						<Option Value="101000934| 0 | 0" >ONE MONTH NOTICE PAYMENT   ME</Option>

						<Option Value="101000385| 0 | 0" >OTHER RAW MATERIAL   MFPL</Option>

						<Option Value="101000784| 0 | 0" >PACKING & FORWARDING-SALES   </Option>

						<Option Value="101000696| 0 | 0" >PACKING & FORWARIDNG PURCHASE   </Option>

						<Option Value="101000974| 0 | 0" >PAINTING CHARGES   </Option>

						<Option Value="101000006|101140037|0" >PATTERN   DI</Option>

						<Option Value="101000006|101140038|0" >PATTERN - JIG & DIES   MSIPL</Option>

						<Option Value="101000398| 0 | 0" >PATTERN MAINTAINCES CHARGES   COM</Option>

						<Option Value="101000772| 0 | 0" >PATTERN REPAIRS   MFPL</Option>

						<Option Value="101000312| 0 | 0" >PF DAMAGES RECOVERED   msipl</Option>

						<Option Value="101000183| 0 | 0" >PIG IRON   com</Option>

						<Option Value="101000006|101140039|0" >PLANT & MACHINERY   DI/MSIPL</Option>

						<Option Value="101000006|101140040|0" >PLANT & MACHINERY  (WIP)   DI</Option>

						<Option Value="101000006|101140072|0" >PLANT & MACHINERY (H-25) WIP   MEPL</Option>

						<Option Value="101000006|101140055|0" >PLANT & MACHINERY (WEIGHBRIDGE)   MFPL</Option>

						<Option Value="101000006|101140092|0" >PLANT & MACHINERY ERRECTION   DI</Option>

						<Option Value="101000006|101140079|0" >PLANT & MACHINERY H-25   H-21</Option>

						<Option Value="101000006|101140041|0" >PLANT & MACHINERY U-1   MEPL/MFPL</Option>

						<Option Value="101000006|101140042|0" >PLANT & MACHINERY U-2   MEPL/MFPL</Option>

						<Option Value="101000006|101140043|0" >PLANT & MACHINERY U-3   MEPL</Option>

						<Option Value="101000603| 0 | 0" >POWDER COATING CHARGES(DOMESTIC)   MEPL</Option>

						<Option Value="101000604| 0 | 0" >POWDER COATING CHARGES(EXPORT)   MEPL</Option>

						<Option Value="101000006|101140095|0" >POWDER COATING WIP   U-III</Option>

						<Option Value="101001222| 0 | 0" >POWER & ELECTRICITY CHARGES - POWDER COATING PLANT   MFPL</Option>

						<Option Value="101000874| 0 | 0" >POWER & ELECTRICITY CHARGES (H-25)   ME H25</Option>

						<Option Value="101000186| 0 | 0" >POWER & ELECTRICITY EXPENSES   com</Option>

						<Option Value="101001140| 0 | 0" >POWER CONSULTANCY CHARGES   DI/MFPL</Option>

						<Option Value="101000609| 0 | 0" >PROFIT ON SALE OF  FREEHOLD LAND-KHINDWADI   MEPL</Option>

						<Option Value="101000779| 0 | 0" >PROFIT ON SALE OF DEPB LICENCE   MEPL</Option>

						<Option Value="101001152| 0 | 0" >PROFIT ON SALE OF FIXTURE   MEPL</Option>

						<Option Value="101001194| 0 | 0" >PROFIT ON SALE OF INNOVA CAR (MH-11-Y-7629)   MEPL</Option>

						<Option Value="101000195| 0 | 0" >PROFIT ON SALE OF MACHINERY   com</Option>

						<Option Value="101000196| 0 | 0" >PROFIT ON SALE OF RELIANCE GROWTH FUND (D)   com</Option>

						<Option Value="101000884| 0 | 0" >PROFIT ON SALE OF SCRAP CAR MH-18 B - 875   </Option>

						<Option Value="101000197| 0 | 0" >PROFIT ON SALE OF SHARES   com</Option>

						<Option Value="101000866| 0 | 0" >PROVISION FOR RATE AMENDMENT   </Option>

						<Option Value="101001174| 0 | 0" >PROVISION FOR RATE REDUCTION   </Option>

						<Option Value="101000433| 0 | 0" >PUR S.G CRC SCRAP   DI </Option>

						<Option Value="101000434| 0 | 0" >PUR. C.I.SCRAP   DI </Option>

						<Option Value="101000435| 0 | 0" >PUR.ALUMINIUM SCRAP   DI </Option>

						<Option Value="101000436| 0 | 0" >PUR.C.I.BOARING   DI </Option>

						<Option Value="101000437| 0 | 0" >PUR.C.I.CASTINGS   DI </Option>

						<Option Value="101000438| 0 | 0" >PUR.COKE   DI </Option>

						<Option Value="101000611| 0 | 0" >PUR.CONS.STORES   MEPL</Option>

						<Option Value="101000612| 0 | 0" >PUR.CONS.TOOLS   MEPL</Option>

						<Option Value="101000439| 0 | 0" >PUR.M.S.SCRAP   DI </Option>

						<Option Value="101000440| 0 | 0" >PUR.OTHER RAW MATERIAL   DI </Option>

						<Option Value="101000441| 0 | 0" >PUR.PIG IRON   DI </Option>

						<Option Value="101000442| 0 | 0" >PUR:-M.S.ROUND BAR   DI </Option>

						<Option Value="101000613| 0 | 0" >PURCHASE (CI+SGI) CASTINGS   MEPL</Option>

						<Option Value="101000614| 0 | 0" >PURCHASE CI SCRAP   MEPL</Option>

						<Option Value="101001000| 0 | 0" >PURCHASE CI/SGI CASTINGS H-25   H25</Option>

						<Option Value="101000615| 0 | 0" >PURCHASE EXPORT CASTING (SGI+CI)   MEPL</Option>

						<Option Value="101000723| 0 | 0" >PURCHASE OF ALUMN.CASTINGS (DOM+EXPORT)   </Option>

						<Option Value="101000387| 0 | 0" >PURCHASE OF CONSUMABLE STORES   MFPL</Option>

						<Option Value="101001081| 0 | 0" >PURCHASE RETURN   </Option>

						<Option Value="101000764| 0 | 0" >PURCHASE RETURN - ALUMN.CASTINGS -DOMESTIC    MEPL</Option>

						<Option Value="101001001| 0 | 0" >PURCHASE RETURN - CI/SGI CASTINGS H-25    H25</Option>

						<Option Value="101000762| 0 | 0" >PURCHASE RETURN - CI/SGI CASTINGS-DOMESTIC    MEPL</Option>

						<Option Value="101000763| 0 | 0" >PURCHASE RETURN - S.G.I CASTINGS-EXPORT    MEPL</Option>

						<Option Value="101000688| 0 | 0" >PURCHASE S G I CASTING   MSIPL</Option>

						<Option Value="101000616| 0 | 0" >PURCHASE SGI SCRAP   MEPL</Option>

						<Option Value="101000443| 0 | 0" >PURCHASE SHELL MOULD (CORE MAKING)   DI </Option>

						<Option Value="101001099| 0 | 0" >PURCHASE TIN INGOT   DI</Option>

						<Option Value="101000444| 0 | 0" >PURCHASE-C.P.COKE   DI </Option>

						<Option Value="101000314| 0 | 0" >QUALITY CONTROL EXPS   msipl</Option>

						<Option Value="101000315| 0 | 0" >R.M. (OTHER)   msipl</Option>

						<Option Value="101000915| 0 | 0" >RATE DIFFERANCE   </Option>

						<Option Value="101000970| 0 | 0" >RATE DIFFERANCE OMS   </Option>

						<Option Value="101000316| 0 | 0" >RAW MATERIAL PURCHASE   msipl</Option>

						<Option Value="101000388| 0 | 0" >RAW SILICA SAND PURCHASE A/C   MFPL</Option>

						<Option Value="101000943| 0 | 0" >RAW SILICA SAND RECLAIMED PURCHASE   </Option>

						<Option Value="101001007| 0 | 0" >REC TRADE  INCOME (INDIAN ENERGY EXCHANGE)   ME</Option>

						<Option Value="101000914| 0 | 0" >REJECTION CHARGES   </Option>

						<Option Value="101000445| 0 | 0" >REJECTION INWORD EXPENSES   DI </Option>

						<Option Value="101001220| 0 | 0" >RENT FOR POWDER COATING PLANT   MFPL</Option>

						<Option Value="101000622| 0 | 0" >RENTING OF IMMOVIABLE PROPERTY-CORP.OFFICE   MEPL</Option>

						<Option Value="101000045| 0 | 0" >REPAIR SALES ACCOUNT   COM</Option>

						<Option Value="101000209| 0 | 0" >REPAIRS & MAINTAINANCE-MACHINERY   com</Option>

						<Option Value="101000389| 0 | 0" >RESIN COATED SAND PURCHASE A/C   MFPL</Option>

						<Option Value="101000390| 0 | 0" >RESIN LIQUID PURCHASE A/C   MFPL</Option>

						<Option Value="101001013| 0 | 0" >REWORK CHARGES - DOMESTIC   ME</Option>

						<Option Value="101000009| 0 | 0" >ROUNDING OFF ACCOUNT   erp a/c</Option>

						<Option Value="101000780| 0 | 0" >SALE ALUMINIUM  BORING   MEPL</Option>

						<Option Value="101001040| 0 | 0" >SALE ALUMINIUM  SCRAP   MEPL</Option>

						<Option Value="101000767| 0 | 0" >SALE ALUMN..MACH.CASTINGS -SALES RETURN   MEPL</Option>

						<Option Value="101000786| 0 | 0" >SALE ALUMN.CASTING OMS 2%   DI</Option>

						<Option Value="101000624| 0 | 0" >SALE C.I.BOARING   MEPL</Option>

						<Option Value="101000948| 0 | 0" >SALE C.I.BOARING SALES RETURN   ME</Option>

						<Option Value="101000785| 0 | 0" >SALE C.I.CASTINGS OMS 2%   DI</Option>

						<Option Value="101000776| 0 | 0" >SALE C.I.MACH.CASTINGS -OMS 2%   MEPL</Option>

						<Option Value="101000766| 0 | 0" >SALE C.I.MACH.CASTINGS -SALES RETURN   MEPL</Option>

						<Option Value="101001207| 0 | 0" >SALE CASTINGS EXPORT  (U-III)   MSIPL</Option>

						<Option Value="101000998| 0 | 0" >SALE CI/SGI CASTINGS    H-25   H25</Option>

						<Option Value="101000999| 0 | 0" >SALE CI/SGI CASTINGS - SALES RETURN H-25   H25</Option>

						<Option Value="101000996| 0 | 0" >SALE CI/SGI MACHINED CASTING  H-25   H25</Option>

						<Option Value="101000997| 0 | 0" >SALE CI/SGI MACHINED CASTING - SALE RETURN  H25   H25</Option>

						<Option Value="101000789| 0 | 0" >SALE- CORES & MOULD   </Option>

						<Option Value="101000951| 0 | 0" >SALE MACH.CASTINGS EXPORT-SALE RETURN   ME</Option>

						<Option Value="101000777| 0 | 0" >SALE MACH.CASTINGS -OMS2% SALES RETURN   MEPL</Option>

						<Option Value="101001070| 0 | 0" >SALE MACHINING DEFECTIVES- REJECTION   MEPL</Option>

						<Option Value="101000950| 0 | 0" >SALE MACHINING/LABOUR CHARGES SALE RETURN   ME</Option>

						<Option Value="101000797| 0 | 0" >SALE MOULDING BOX   DI</Option>

						<Option Value="101000625| 0 | 0" >SALE OF DEPB LICENCE   MEPL</Option>

						<Option Value="101000980| 0 | 0" >SALE OF WIND POWER ELECTRICITY   MEPL</Option>

						<Option Value="101000790| 0 | 0" >SALE OTHER   DI</Option>

						<Option Value="101000833| 0 | 0" >SALE PIG IRON   DI</Option>

						<Option Value="101000765| 0 | 0" >SALE PURCHASE (REJ.) ALUMN.CASTINGS -EXPORT   MEPL</Option>

						<Option Value="101001075| 0 | 0" >SALE RATE REDUCTION ALUMN.CASTINGS   DI</Option>

						<Option Value="101001074| 0 | 0" >SALE RATE REDUCTION C.I.CASTINGS   DI</Option>

						<Option Value="101000931| 0 | 0" >SALE RATE REDUCTION -DOMESTIC   MEPL</Option>

						<Option Value="101001209| 0 | 0" >SALE RATE REDUCTION -DOMESTIC H-25   MEPL II</Option>

						<Option Value="101000933| 0 | 0" >SALE RATE REDUCTION -EXPORT   MEPL</Option>

						<Option Value="101000932| 0 | 0" >SALE RATE REDUCTION OMS 2%   ME</Option>

						<Option Value="101000944| 0 | 0" >SALE RAW SILICA SAND RECLAIMED   </Option>

						<Option Value="101000949| 0 | 0" >SALE S.G.I.BOARING SALE RETURN   MEPL</Option>

						<Option Value="101000629| 0 | 0" >SALE-AIR FREIGHT-(INCOME)   MEPL</Option>

						<Option Value="101000630| 0 | 0" >SALE-MACHINED CASTINGS-DOMESTIC   MEPL</Option>

						<Option Value="101000631| 0 | 0" >SALE-MACHINED CASTINGS-EXPORT   MEPL</Option>

						<Option Value="101000773| 0 | 0" >SALE-MACHINING/LABOUR CHARGES   </Option>

						<Option Value="101000632| 0 | 0" >SALE-PLANT &MACHINERY U3   MEPL</Option>

						<Option Value="101000392| 0 | 0" >SALES - EXPORT   MFPL</Option>

						<Option Value="101000633| 0 | 0" >SALES - TOOL COST   MEPL</Option>

						<Option Value="101001218| 0 | 0" >SALES - TOOLS COST EXPORT   MEPL</Option>

						<Option Value="101000447| 0 | 0" >SALES ALUMN.CASTINGS   DI </Option>

						<Option Value="101001172| 0 | 0" >SALES ALUMN.CASTINGS - SALES RETURN   DI</Option>

						<Option Value="101000774| 0 | 0" >SALES ALUMN.CASTINGS (DOMESTIC)   </Option>

						<Option Value="101000775| 0 | 0" >SALES ALUMN.CASTINGS (EXPORT)   </Option>

						<Option Value="101001082| 0 | 0" >SALES ALUMN.CASTINGS (OMS 2%)   ME</Option>

						<Option Value="101001083| 0 | 0" >SALES ALUMN.CASTINGS (OMS 2%) SALES RETURN   ME</Option>

						<Option Value="101000448| 0 | 0" >SALES C.I.CASTINGS   COM</Option>

						<Option Value="101001170| 0 | 0" >SALES C.I.CASTINGS - SALES RETURN   DI</Option>

						<Option Value="101001171| 0 | 0" >SALES C.I.CASTINGS OMS 2% - SALES RETURN   DI</Option>

						<Option Value="101000634| 0 | 0" >SALES C.I.SCRAP   MEPL</Option>

						<Option Value="101001085| 0 | 0" >SALES CAS 4   </Option>

						<Option Value="101000783| 0 | 0" >SALES CASTING -OMS   </Option>

						<Option Value="101001010| 0 | 0" >SALES COMPUTER   </Option>

						<Option Value="101000891| 0 | 0" >SALES CONSUMABLE MATERIAL   MSIPL</Option>

						<Option Value="101000865| 0 | 0" >SALES CREDIT NOTE ACCOUNTS ONLY   MSIPL</Option>

						<Option Value="101001169| 0 | 0" >SALES CREDIT NOTE ACCOUNTS ONLY - OMS   MSIPL</Option>

						<Option Value="101000460| 0 | 0" >SALES OF DEPB LICENCE   MEPL/DI</Option>

						<Option Value="101000451| 0 | 0" >SALES- PLANT & MACHINERY   DI </Option>

						<Option Value="101000394| 0 | 0" >SALES R.C. SAND   MFPL</Option>

						<Option Value="101000890| 0 | 0" >SALES RAW MATERIAL   MSIPL</Option>

						<Option Value="101000319| 0 | 0" >SALES S. G. IRON CASTINGS   COM</Option>

						<Option Value="101000864| 0 | 0" >SALES S. G. IRON CASTINGS- OMS   MSIPL</Option>

						<Option Value="101000638| 0 | 0" >SALES S.G.I. SCRAP   MEPL</Option>

						<Option Value="101000639| 0 | 0" >SALES S.G.I.BOARING   MEPL</Option>

						<Option Value="101000395| 0 | 0" >SALES SHELL MOULD   MFPL</Option>

						<Option Value="101001077| 0 | 0" >SALES TAX REFUND 2005-06   MEPL</Option>

						<Option Value="101000456| 0 | 0" >SALES-C. I. BOARING   DI </Option>

						<Option Value="101000641| 0 | 0" >SALES-MACHINING CHARGES   MEPL</Option>

						<Option Value="101000642| 0 | 0" >SALES-TOOL/DRILL/TAPS (SCRAP)   MEPL</Option>

						<Option Value="101001071| 0 | 0" >SALES-TOOLS & EQUIPMENTS   MFPL</Option>

						<Option Value="101000947| 0 | 0" >SCHEDULE ADHELS PENALTY   ME</Option>

						<Option Value="101000822| 0 | 0" >SCHEME OF DUTY DRAWBACK RECEIPT   MEPL</Option>

						<Option Value="101000039| 0 | 0" >SCRAP SALES   COM</Option>

						<Option Value="101000215| 0 | 0" >SECURITY EXPENSES   com</Option>

						<Option Value="101000938| 0 | 0" >SEGREGATION & REWORK CHARGES   </Option>

						<Option Value="101000321| 0 | 0" >SHOTBLASTING EXPS   msipl</Option>

						<Option Value="101000322| 0 | 0" >SPECTRO TESTING  CHARGES   msipl</Option>

						<Option Value="101001135| 0 | 0" >SPILLAGE COLLECTION CHARGES   MSIPL</Option>

						<Option Value="101001100| 0 | 0" >SUNDRY DEBTORS SETTLEMENT ACCOUNT   MEPL </Option>

						<Option Value="101001101| 0 | 0" >SUNDRY DEBTORS SETTLMENT A/C   MEPL</Option>

						<Option Value="101000403| 0 | 0" >TIN PURCHASE A/C   MFPL</Option>

						<Option Value="101000006|101140066|0" >TOOLS & EQUIPMENT   MFPL</Option>

						<Option Value="101000006|101140045|0" >TOOLS & EQUIPMENT U-1   MEPL</Option>

						<Option Value="101000006|101140046|0" >TOOLS & EQUIPMENT U-2   MEPL</Option>

						<Option Value="101000989| 0 | 0" >TOOLS GRINDING/RESHARPNING CHARGES-DOMESTIC   ME</Option>

						<Option Value="101000990| 0 | 0" >TOOLS GRINDING/RESHARPNING CHARGES-EXPORT   ME</Option>

						<Option Value="101000006|101140080|0" >TRACTOR TRAILOR RED (TROLLEY)   MEPL</Option>

						<Option Value="101000099| 0 | 0" >TRANSPORT  CHARGES (INWARD)   com</Option>

						<Option Value="101000242| 0 | 0" >TRANSPORT CHARGES (OUTWARD)   com</Option>

						<Option Value="101000461| 0 | 0" >TRANSPORT CHARGES (SALES)   DI </Option>

						<Option Value="101000243| 0 | 0" >TRANSPORT CHARGES LOCAL   com</Option>

						<Option Value="101000006|101140047|0" >TYPE WRITER   MEPL</Option>

						<Option Value="101000981| 0 | 0" >VALUE OF UNITS GENERATED-WTG   MEPL</Option>

						<Option Value="101001012| 0 | 0" >VANEDIUM PURCHASE   </Option>

						<Option Value="101001131| 0 | 0" >VAT REFUND 2010-11   DI</Option>

						<Option Value="101000006|101140091|0" >VEHICLE - FORD ECO SPORTS   DI</Option>

						<Option Value="101000006|101140097|0" >VEHICLE - INNOVA CRYSTA MH-11-BV-7022   DI</Option>

						<Option Value="101000667| 0 | 0" >VENDOR MACHINE SHOP EXPS.   MEPL</Option>

						<Option Value="101000251| 0 | 0" >WATER CHARGES   com</Option>

						<Option Value="101001221| 0 | 0" >WATER CHARGES - POWDER COATING PLANT   MFPL</Option>

						<Option Value="101000875| 0 | 0" >WATER CHARGES (H-25)   MEPL</Option>

						<Option Value="101000253| 0 | 0" >WEIGHMENT CHARGES   com</Option>

						<Option Value="101000929| 0 | 0" >WIND ENERGY CHARGES RECEIVED FROM MSEDCL   MEPL</Option>

						<Option Value="101000006|101140083|0" >WINDMILL   MEPL</Option>

						<Option Value="101000006|101140089|0" >WIP LINER PROJECT   </Option>

						<Option Value="101000006|101140096|0" >WIP PLANT & MACHINERY (POWDER COATING PLANT)   MFPL</Option>

						<Option Value="101000006|101140075|0" >WIP PLANT AND MACHINARY   MSIPL</Option>

						<Option Value="101000006|101140065|0" >WIP VINAR & PAINT SHOP PROJECT   MFPL</Option>

						<Option Value="101000006|101140070|0" >WORKS EQUIPMENTS   DI</Option>

				</select>
			</Td>
		</tr>
		<tr>
			<td width="05%" colspan="05" align="left"> &nbsp</td>
			<Td Width="25%" colspan="25" align="left">
				<label class="caption">Stock List Group </label>
			</Td>
			<Td Width="20%" colspan="20" align="left">
				
				<Select id="drpAcctGroup" name="drpAcctGroup"  TabIndex="31" >
				
					<Option Value="1010148" >CASTING</Option>
					
					<Option Value="1010164" >CASTING</Option>
					
					<Option Value="1010163" >FINISH PRODUCT</Option>
					
				</select>
			</Td>

			<td Width="15%" colspan="15" align="left">
				<label class="caption">Store Location</label>
			</td>
			<td Width="25%" colspan="25" align="left">
				<Select id="drpLocCode" name="drpLocCode"  TabIndex="32" >
				
					<Option Value="101002" >FINISH STOCK YARD</Option>
					
					<Option Value="101001" >STORE</Option>
					
				</select>
			</td>

		</tr>
		<tr>
			<td width="05%" colspan="05" align="left"> &nbsp</td>
			<td Width="25%" colspan="25" align="left">
				<label class="caption">BHN Specification</label>
			</td>
			<td Width="20%" colspan="20" align="left">
				<Input Type="Text" Id="txtBHNSpec" name="txtBHNSpec" TabIndex="33"  Size="20" MaxLength="20" >
			</td>
			<td Width="15%" colspan="15" align="left">
				<label class="caption" >Old System Code</label>
			</td>
			<td Width="25%" colspan="25" align="left">
				<Input Type="Text" Id="txtOldCode" name="txtOldCode" TabIndex="34"  Size="15" MaxLength="10"  >
			</td>
		</tr>
		<tr>
			<td width="30%" colspan="30" align="left"> &nbsp</td>
			<td width="75%" colspan="75" align="left" valign="center">
				<input type="checkbox" name="chkWTinputSale"  Class="check" TabIndex=35 >
				<label class="caption">Is Wt.Input in Invoice</label>
			</td>
		</tr>
		<tr>
			<td width="05%" colspan="05" align="left"> &nbsp</td>
			<td Width="25%" colspan="25" align="left" valign="top">
				<label class="caption">Remark</label>
			</td>
			<td Width="70%" colspan="70" align="left">
				<textarea id="txtAddSpec" name="txtAddSpec" TabIndex="36"  Cols=52 rows=3 OnKeyup="CheckTextAreaLength(this , 500)" OnKeyDown="CheckTextAreaLength(this , 500)" > </textarea>
			</td>
		</tr>
	</table>
</body>
</html>