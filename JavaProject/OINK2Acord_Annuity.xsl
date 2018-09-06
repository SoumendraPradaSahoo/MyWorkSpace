<!-- CHANGE LOG -->
<!-- Audit Number Version Change Description -->
<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:java="http://xml.apache.org/xslt/java">
	<xsl:output method="xml" encoding="UTF-8" version="1.0" />
	<xsl:param name="xslPath" />
	<xsl:param name="current_date" />
	<xsl:param name="current_time" />
	<xsl:param name="LTCR" />
	<xsl:param name="EOBR" />
	<xsl:param name="ILTCR" />
	<xsl:param name="IndexLTCR" />
	<xsl:param name="DefLifeInsMethodtc" />
	<xsl:param name="DefLifeInsMethod" />
	<xsl:template match="/">
		<xsl:variable name="uid"
			select="java:java.util.UUID.randomUUID()" />
		<TXLife xmlns:java="http://xml.apache.org/xslt/java"
			xmlns:xsd="http://www.w3.org/2001/XMLSchema"
			xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
			<UserAuthRequest>
				<UserLoginName>TXADMIN</UserLoginName>
				<UserPswd>
					<CryptType>NONE</CryptType>
					<Pswd>SYSADMIN</Pswd>
				</UserPswd>
			</UserAuthRequest>
			<TXLifeRequest>
				<TransRefGUID>
					<xsl:value-of select="$uid" />
				</TransRefGUID>
				<TransType tc="103">New Business Application</TransType>
				<TransExeDate>
					<xsl:value-of select="$current_date" />
				</TransExeDate>
				<TransExeTime>
					<xsl:value-of select="$current_time" />
				</TransExeTime>
				<TransMode tc="2">Original</TransMode>
				<OLifE Version="2.8.90">
					<SourceInfo>
						<FileControlID>VNTG</FileControlID>
					</SourceInfo>
					<!-- NB Holding START -->
					<Holding id="Holding_1">
						<HoldingTypeCode tc="2">Policy</HoldingTypeCode>
						<Policy>
							<xsl:if
								test="string-length(instanceData/TXLife/A_PolNumber)>0">
								<PolNumber>
									<xsl:value-of
										select="instanceData/TXLife/A_PolNumber" />
								</PolNumber>
							</xsl:if>
							<LineOfBusiness tc="2">Annuity</LineOfBusiness>
							<!-- Citation Required -->
							<ProductType>
								<xsl:attribute name="tc">
									<xsl:value-of select="instanceData/TXLife/A_PRODUCTCODE" />
								</xsl:attribute>
								<xsl:value-of
									select="instanceData/TXLife/A_PRODUCTCODE_Desc" />
							</ProductType>
							<ProductCode>
								<xsl:value-of
									select="instanceData/TXLife/A_ProductCode_Annuity" />
							</ProductCode>
							<CarrierCode>
								<xsl:value-of
									select="instanceData/TXLife/A_CarrierCode" />
							</CarrierCode>
							<ReplacementType>
								<xsl:attribute name="tc">
									<xsl:value-of
									select="instanceData/TXLife/A_ReplacmentType_LifeHolding" />
								</xsl:attribute>
								<xsl:value-of
									select="instanceData/TXLife/A_ReplacmentType_LifeHolding_Desc" />
							</ReplacementType>
							<!-- <xsl:if test="./instanceData/TXLife/A_PaymentMode != '9'"> <PaymentMode> 
								<xsl:attribute name="tc"> <xsl:value-of select="instanceData/TXLife/A_PaymentMode" 
								/> </xsl:attribute> <xsl:value-of select="instanceData/TXLife/A_PaymentMode_Desc" 
								/> </PaymentMode> </xsl:if> -->
							<xsl:choose>
								<xsl:when
									test="string-length(instanceData/TXLife/A_Total_Amount_PPAY) = 0 ">
									<PaymentAmt>0</PaymentAmt>
								</xsl:when>
								<xsl:when
									test="contains(instanceData/TXLife/A_Total_Amount_PPAY ,'$')">
									<PaymentAmt>
										<xsl:value-of
											select="translate(substring-after(instanceData/TXLife/A_Total_Amount_PPAY, '$'),',','')" />
									</PaymentAmt>
								</xsl:when>
								<xsl:when
									test="not(contains(instanceData/TXLife/A_Total_Amount_PPAY ,'$'))">
									<PaymentAmt>
										<xsl:value-of
											select="translate(instanceData/TXLife/A_Total_Amount_PPAY,',','')" />
									</PaymentAmt>
								</xsl:when>
							</xsl:choose>
							<!-- <xsl:choose> <xsl:when test="./instanceData/TXLife/A_Wire_MPREM 
								= '1009900004' "> <PaymentMethod tc="2">Wire Transfer</PaymentMethod> </xsl:when> 
								<xsl:when test="./instanceData/TXLife/A_Check_MPREM = '1009900003' "> <PaymentMethod 
								tc="2">Check</PaymentMethod> </xsl:when> <xsl:when test="./instanceData/TXLife/A_EFT_MPREM 
								= '7' "> <PaymentMethod tc="7">Electronic Fund Transfer </PaymentMethod> 
								</xsl:when> <xsl:when test="./instanceData/TXLife/TXLife/A_PaymentMode = 
								'9'"> <PaymentMethod tc="20">Single Premium</PaymentMethod> </xsl:when> </xsl:choose> -->
							<xsl:if
								test="./instanceData/TXLife/A_CashWithAppInd = '1' ">
								<PaymentDraftDay>
									<xsl:value-of
										select="instanceData/TXLife/A_DebitDay" />
								</PaymentDraftDay>
							</xsl:if>
							<Annuity>
								<PremType>
									<xsl:attribute name="tc">
												<xsl:value-of
										select="instanceData/TXLife/A_PremType" />
											</xsl:attribute>
									<xsl:value-of
										select="instanceData/TXLife/A_PremType_Desc" />
								</PremType>
								<QualPlanType>
									<xsl:attribute name="tc">
												<xsl:value-of
										select="instanceData/TXLife/A_ContractAppliedFor" />
											</xsl:attribute>
									<xsl:value-of
										select="instanceData/TXLife/A_ContractAppliedFor_Desc" />
								</QualPlanType>
								<!-- Citation Required -->
								<xsl:if
									test="string-length(instanceData/TXLife/A_TotalWithdrawal)>0 ">
									<xsl:choose>
										<xsl:when
											test="contains(instanceData/TXLife/A_TotalWithdrawal ,'$')">
											<InitialPremAmt>
												<xsl:value-of
													select="translate(substring-after(instanceData/TXLife/A_TotalWithdrawal, '$'),',','')" />
											</InitialPremAmt>
										</xsl:when>
										<xsl:when
											test="not(contains(instanceData/TXLife/A_TotalWithdrawal ,'$'))">
											<InitialPremAmt>
												<xsl:value-of
													select="translate(instanceData/TXLife/A_TotalWithdrawal,',','')" />
											</InitialPremAmt>
										</xsl:when>
									</xsl:choose>
								</xsl:if>
								<xsl:if
									test="string-length(instanceData/TXLife/A_AmtCollectedMPREM)>0 and string-length(instanceData/TXLife/A_AmtCollected_TIA)=0 ">
									<xsl:choose>
										<xsl:when
											test="contains(instanceData/TXLife/A_AmtCollectedMPREM ,'$')">
											<InitialPremAmt>
												<xsl:value-of
													select="translate(substring-after(instanceData/TXLife/A_AmtCollectedMPREM, '$'),',','')" />
											</InitialPremAmt>
										</xsl:when>
										<xsl:when
											test="not(contains(instanceData/TXLife/A_AmtCollectedMPREM ,'$'))">
											<InitialPremAmt>
												<xsl:value-of
													select="translate(instanceData/TXLife/A_AmtCollectedMPREM,',','')" />
											</InitialPremAmt>
										</xsl:when>
									</xsl:choose>
								</xsl:if>
								<Payout id="Payout_1">
									<PayoutMode>
										<xsl:attribute name="tc">
										<xsl:value-of
											select="instanceData/TXLife/A_IncomePayment_Freq" />
									</xsl:attribute>
										<xsl:value-of
											select="instanceData/TXLife/A_IncomePayment_Freq_Desc" />
									</PayoutMode>
									<xsl:if
										test="string-length(instanceData/TXLife/A_IncomePayment_Start_Date)>0">
										<StartDate>
											<xsl:call-template name="FormatDate">
												<xsl:with-param name="Separator">
													/
												</xsl:with-param>
												<xsl:with-param name="DateString">
													<xsl:value-of
														select="instanceData/TXLife/A_IncomePayment_Start_Date" />
												</xsl:with-param>
											</xsl:call-template>
										</StartDate>
									</xsl:if>
									<xsl:choose>
										<xsl:when
											test="instanceData/TXLife/A_FederalTaxCB = '1'">
											<TaxWithheldInd tc="0">False</TaxWithheldInd>
										</xsl:when>
										<xsl:when
											test="instanceData/TXLife/A_FederalTaxCB != '1' and 
											(string-length(instanceData/TXLife/A_FederalTax_Withhold_Amt)>0 or
											string-length(instanceData/TXLife/A_FederalTax_Withhold_Per)>0 ) ">
											<TaxWithheldInd tc="1">True</TaxWithheldInd>
										</xsl:when>
									</xsl:choose>
									<Participant id="PayoutParticipant_1"
										PartyID="Party_PINS">
										<ParticipantRoleCode tc="27">Annuitant
										</ParticipantRoleCode>
									</Participant>
									<xsl:if test="./instanceData/TXLife/A_JointAnnInd = '1'">
										<Participant id="PayoutParticipant_2"
											PartyID="Party_JNT">
											<ParticipantRoleCode tc="28">Joint Annuitant
											</ParticipantRoleCode>
										</Participant>
									</xsl:if>
									<xsl:if
										test="string-length(instanceData/TXLife/A_FederalTax_Withhold_Amt)>0 or
											string-length(instanceData/TXLife/A_FederalTax_Withhold_Per)>0 ">
										<TaxWithholding id="TaxWithholding_1">
											<TaxWithholdingPlace tc="1">Federal Tax
											</TaxWithholdingPlace>
											<TaxWithholdingType>
												<xsl:attribute name="tc"><xsl:value-of
													select="instanceData/TXLife/A_FederalTax_Withhold_Type" />
												</xsl:attribute>
												<xsl:value-of
													select="instanceData/TXLife/A_FederalTax_Withhold_Type_Desc" />
											</TaxWithholdingType>
											<xsl:if
												test="instanceData/TXLife/A_FederalTax_Withhold_Type = '6' ">
												<TaxWithheldPct>
													<xsl:value-of
														select="instanceData/TXLife/A_FederalTax_Withhold_Per" />
												</TaxWithheldPct>
											</xsl:if>
											<xsl:if
												test="instanceData/TXLife/A_FederalTax_Withhold_Type = '8' ">
												<xsl:choose>
													<xsl:when
														test="contains(instanceData/TXLife/A_FederalTax_Withhold_Amt ,'$')">
														<TaxWithheldAmt>
															<xsl:value-of
																select="translate(substring-after(instanceData/TXLife/A_FederalTax_Withhold_Amt, '$'),',','')" />
														</TaxWithheldAmt>
													</xsl:when>
													<xsl:when
														test="not(contains(instanceData/TXLife/A_FederalTax_Withhold_Amt ,'$'))">
														<TaxWithheldAmt>
															<xsl:value-of
																select="translate(instanceData/TXLife/A_FederalTax_Withhold_Amt,',','')" />
														</TaxWithheldAmt>
													</xsl:when>
												</xsl:choose>
											</xsl:if>
											<OLifEExtension
												ExtensionCode="TaxWithholding 2.8.90" VendorCode="05">
												<TaxWithholdingExtension>
													<FedTaxMarStat>
														<xsl:attribute name="tc"><xsl:value-of
															select="instanceData/TXLife/A_FederalTax_Marital_Status" />
														</xsl:attribute>
														<xsl:value-of
															select="instanceData/TXLife/A_FederalTax_Marital_Status_Desc" />
													</FedTaxMarStat>
													<WithholdingNumExemptions>
														<xsl:value-of
															select="instanceData/TXLife/A_FederalTax_Allowances_Claim" />
													</WithholdingNumExemptions>
												</TaxWithholdingExtension>
											</OLifEExtension>
										</TaxWithholding>
									</xsl:if>
									<xsl:if
										test="string-length(instanceData/TXLife/A_StateTax_Withhold_Amt)>0 or
											string-length(instanceData/TXLife/A_StateTax_Withhold_Per)>0 ">
										<TaxWithholding id="TaxWithholding_2">
											<TaxWithholdingPlace tc="2">State Tax
											</TaxWithholdingPlace>
											<TaxWithholdingType>
												<xsl:attribute name="tc"><xsl:value-of
													select="instanceData/TXLife/A_StateTax_Withhold_Type" />
												</xsl:attribute>
												<xsl:value-of
													select="instanceData/TXLife/A_StateTax_Withhold_Type_Desc" />
											</TaxWithholdingType>
											<xsl:if
												test="instanceData/TXLife/A_StateTax_Withhold_Type = '6' ">
												<TaxWithheldPct>
													<xsl:value-of
														select="instanceData/TXLife/A_StateTax_Withhold_Per" />
												</TaxWithheldPct>
											</xsl:if>
											<xsl:if
												test="instanceData/TXLife/A_StateTax_Withhold_Type = '8' ">
												<xsl:choose>
													<xsl:when
														test="contains(instanceData/TXLife/A_StateTax_Withhold_Amt ,'$')">
														<TaxWithheldAmt>
															<xsl:value-of
																select="translate(substring-after(instanceData/TXLife/A_StateTax_Withhold_Amt, '$'),',','')" />
														</TaxWithheldAmt>
													</xsl:when>
													<xsl:when
														test="not(contains(instanceData/TXLife/A_StateTax_Withhold_Amt ,'$'))">
														<TaxWithheldAmt>
															<xsl:value-of
																select="translate(instanceData/TXLife/A_StateTax_Withhold_Amt,',','')" />
														</TaxWithheldAmt>
													</xsl:when>
												</xsl:choose>
											</xsl:if>
										</TaxWithholding>
									</xsl:if>
									<OLifEExtension ExtensionCode="Payout 2.8.90"
										VendorCode="05">
										<PayoutExtension>
											<IncomeType>
												<xsl:attribute name="tc"><xsl:value-of
													select="instanceData/TXLife/A_LifeTime_Income_Single" />
												</xsl:attribute>
												<xsl:value-of
													select="instanceData/TXLife/A_LifeTime_Income_Single_Desc" />
											</IncomeType>
											<xsl:if
												test="instanceData/TXLife/A_PaymentPerc_Surviver = '1' ">
												<SurvivorPaymntPct>75</SurvivorPaymntPct>
											</xsl:if>
											<xsl:if
												test="instanceData/TXLife/A_PaymentPerc_Surviver = '2' ">
												<SurvivorPaymntPct>66</SurvivorPaymntPct>
											</xsl:if>
											<xsl:if
												test="instanceData/TXLife/A_PaymentPerc_Surviver = '3' ">
												<SurvivorPaymntPct>50</SurvivorPaymntPct>
											</xsl:if>
											<SurvivorPaymntOption>
												<xsl:attribute name="tc"><xsl:value-of
													select="instanceData/TXLife/A_Payment_ReductionType" />
												</xsl:attribute>
												<xsl:value-of
													select="instanceData/TXLife/A_Payment_ReductionType_Desc" />
											</SurvivorPaymntOption>
											<CashOutOption>
												<xsl:attribute name="tc"><xsl:value-of
													select="instanceData/TXLife/A_Opt_Features_Increase_Opt" />
												</xsl:attribute>
												Increasing Income Option
											</CashOutOption>
											<IncomeOptionPct>
												<xsl:value-of
													select="instanceData/TXLife/A_Opt_Features_Increase_Opt_Perc" />
											</IncomeOptionPct>
											<IncomeStartAge>
												<xsl:value-of
													select="instanceData/TXLife/A_IncomePayment_Start_Age" />
											</IncomeStartAge>
										</PayoutExtension>
									</OLifEExtension>
								</Payout>
								<!--Rider Implementation -->
								<!--Living Benefit Rider -->
								<xsl:if
									test="(string-length(instanceData/TXLife/A_LivingBenefit_Riders_Desc)>0 and 
										./instanceData/TXLife/A_LivingBenefit_Riders != '1')">
									<Rider id="Rider_1">
										<RiderTypeCode tc="327">Living Benefit Rider
										</RiderTypeCode>
										<RiderCode>
											<xsl:value-of
												select="instanceData/TXLife/A_LivingBenefit_Riders" />
										</RiderCode>
										<Participant id="Participant_1_1"
											PartyID="Party_PINS">
											<ParticipantRoleCode tc="27">Annuitant
											</ParticipantRoleCode>
										</Participant>
										<xsl:if
											test="./instanceData/TXLife/A_JointAnnInd = '1'">
											<Participant id="Participant_1_2"
												PartyID="Party_JNT">
												<ParticipantRoleCode tc="28">Joint Annuitant
												</ParticipantRoleCode>
											</Participant>
										</xsl:if>
										<OLifEExtension ExtensionCode="Rider 2.8.90"
											VendorCode="05">
											<AnnuityRiderExtension>
												<xsl:if
													test="./instanceData/TXLife/A_JointAnnInd != '1'">
													<LivesType tc="1">Single Life</LivesType>
												</xsl:if>
												<xsl:if
													test="./instanceData/TXLife/A_JointAnnInd = '1'">
													<LivesType tc="2">Joint Life</LivesType>
												</xsl:if>
											</AnnuityRiderExtension>
										</OLifEExtension>
									</Rider>
								</xsl:if>
								<!--Death Benefit Rider -->
								<xsl:if
									test="(string-length(instanceData/TXLife/A_DeathBenefit_Riders_Desc)>0 and 
										./instanceData/TXLife/A_DeathBenefit_Riders != '1')">
									<Rider id="Rider_2">
										<RiderTypeCode tc="206">Death Benefit Rider
										</RiderTypeCode>
										<RiderCode>
											<xsl:value-of
												select="instanceData/TXLife/A_DeathBenefit_Riders" />
										</RiderCode>
										<Participant id="Participant_2_1"
											PartyID="Party_PINS">
											<ParticipantRoleCode tc="27">Annuitant
											</ParticipantRoleCode>
										</Participant>
										<xsl:if
											test="./instanceData/TXLife/A_JointAnnInd = '1'">
											<Participant id="Participant_2_2"
												PartyID="Party_JNT">
												<ParticipantRoleCode tc="28">Joint Annuitant
												</ParticipantRoleCode>
											</Participant>
										</xsl:if>
										<OLifEExtension ExtensionCode="Rider 2.8.90"
											VendorCode="05">
											<AnnuityRiderExtension>
												<xsl:if
													test="./instanceData/TXLife/A_JointAnnInd != '1'">
													<LivesType tc="1">Single Life</LivesType>
												</xsl:if>
												<xsl:if
													test="./instanceData/TXLife/A_JointAnnInd = '1'">
													<LivesType tc="2">Joint Life</LivesType>
												</xsl:if>
											</AnnuityRiderExtension>
										</OLifEExtension>
									</Rider>
								</xsl:if>
								<!-- Earning Preservation Benefit Rider -->
								<xsl:if test="./instanceData/TXLife/A_EPBCB = 'ER'">
									<Rider id="Rider_3">
										<RiderTypeCode tc="205">Earning Preservation Benefit
											Rider
										</RiderTypeCode>
										<RiderCode>ER</RiderCode>
										<Participant id="Participant_3_1"
											PartyID="Party_PINS">
											<ParticipantRoleCode tc="27">Annuitant
											</ParticipantRoleCode>
										</Participant>
										<xsl:if
											test="./instanceData/TXLife/A_JointAnnInd = '1'">
											<Participant id="Participant_3_2"
												PartyID="Party_JNT">
												<ParticipantRoleCode tc="28">Joint Annuitant
												</ParticipantRoleCode>
											</Participant>
										</xsl:if>
										<OLifEExtension ExtensionCode="Rider 2.8.90"
											VendorCode="05">
											<AnnuityRiderExtension>
												<xsl:if
													test="./instanceData/TXLife/A_JointAnnInd != '1'">
													<LivesType tc="1">Single Life</LivesType>
												</xsl:if>
												<xsl:if
													test="./instanceData/TXLife/A_JointAnnInd = '1'">
													<LivesType tc="2">Joint Life</LivesType>
												</xsl:if>
											</AnnuityRiderExtension>
										</OLifEExtension>
									</Rider>
								</xsl:if>
								<!-- Principal Guarantee Rider -->
								<!-- Citation Required -->
								<xsl:if test="./instanceData/TXLife/A_PGRCB = '1'">
									<Rider id="Rider_4">
										<RiderTypeCode tc="?">Principal Guarantee Rider
										</RiderTypeCode>
										<RiderCode>?</RiderCode>
										<Participant id="Participant_4_1"
											PartyID="Party_PINS">
											<ParticipantRoleCode tc="27">Annuitant
											</ParticipantRoleCode>
										</Participant>
										<xsl:if
											test="./instanceData/TXLife/A_JointAnnInd = '1'">
											<Participant id="Participant_4_2"
												PartyID="Party_JNT">
												<ParticipantRoleCode tc="28">Joint Annuitant
												</ParticipantRoleCode>
											</Participant>
										</xsl:if>
										<OLifEExtension ExtensionCode="Rider 2.8.90"
											VendorCode="05">
											<AnnuityRiderExtension>
												<xsl:if
													test="./instanceData/TXLife/A_JointAnnInd != '1'">
													<LivesType tc="1">Single Life</LivesType>
												</xsl:if>
												<xsl:if
													test="./instanceData/TXLife/A_JointAnnInd = '1'">
													<LivesType tc="2">Joint Life</LivesType>
												</xsl:if>
											</AnnuityRiderExtension>
										</OLifEExtension>
									</Rider>
								</xsl:if>
								<!-- Citation Required -->
								<AnnuityUSA>
									<DefLifeInsMethod>
										<xsl:attribute name="tc">
											<xsl:value-of select="$DefLifeInsMethodtc" />
										</xsl:attribute>
										<xsl:value-of select="$DefLifeInsMethod" />
									</DefLifeInsMethod>
									<!-- BHFD-530 -->
									<xsl:if
										test="./instanceData/TXLife/A_Internal1035 = '1'">
										<Internal1035 tc="1">true</Internal1035>
									</xsl:if>
									<xsl:if
										test="./instanceData/TXLife/A_Internal1035 = '0'">
										<Internal1035 tc="0">false</Internal1035>
									</xsl:if>
								</AnnuityUSA>
							</Annuity>
							<ApplicationInfo>
								<ApplicationType tc="1">New</ApplicationType>
								<ApplicationJurisdiction>
									<xsl:attribute name="tc">
										<xsl:value-of
										select="instanceData/TXLife/A_ApplicationJurisdiction" />
									</xsl:attribute>
									<xsl:value-of
										select="instanceData/TXLife/A_ApplicationJurisdiction_Desc" />
								</ApplicationJurisdiction>
								<FormalAppInd tc="1">True</FormalAppInd>
								<xsl:if
									test="./instanceData/TXLife/A_SignatureMethod = '1'">
									<!-- wet signature paper aap case -->
									<xsl:choose>
										<xsl:when
											test="string-length(instanceData/TXLife/A_SignatureDate)>0">
											<SignedDate>
												<xsl:call-template name="FormatDate">
													<xsl:with-param name="Separator">
														/
													</xsl:with-param>
													<xsl:with-param name="DateString">
														<xsl:value-of
															select="instanceData/TXLife/A_SignatureDate" />
													</xsl:with-param>
												</xsl:call-template>
											</SignedDate>
										</xsl:when>
										<xsl:otherwise>
											<SignedDate>
												<xsl:value-of select="$current_date" />
											</SignedDate>
										</xsl:otherwise>
									</xsl:choose>
									<SubmissionDate>
										<xsl:value-of
											select="instanceData/TXLife/A_AppReceive_Date" />
									</SubmissionDate>
									<SubmissionTime>
										<xsl:value-of select="$current_time" />
									</SubmissionTime>
									<SubmissionType tc="1">Paper</SubmissionType>
								</xsl:if>
								<xsl:if
									test="./instanceData/TXLife/A_SignatureMethod = '1'">
									<!-- Annuitant = Owner -->
									<xsl:if
										test="./instanceData/TXLife/A_OwnOtherThanAnn != '1'">
										<xsl:if
											test="./instanceData/TXLife/A_PISignatureOK = '0'">
											<AppOwnerSignatureOK tc="0">False
											</AppOwnerSignatureOK>
										</xsl:if>
										<xsl:if
											test="./instanceData/TXLife/A_PISignatureOK = '1'">
											<AppOwnerSignatureOK tc="1">True
											</AppOwnerSignatureOK>
										</xsl:if>
									</xsl:if>
									<!-- Annuitant <> Owner -->
									<xsl:if
										test="./instanceData/TXLife/A_OwnOtherThanAnn = '1'">
										<xsl:if
											test="./instanceData/TXLife/A_OwnerSignatureOK = '0'">
											<AppOwnerSignatureOK tc="0">False
											</AppOwnerSignatureOK>
										</xsl:if>
										<xsl:if
											test="./instanceData/TXLife/A_OwnerSignatureOK = '1'">
											<AppOwnerSignatureOK tc="1">True
											</AppOwnerSignatureOK>
										</xsl:if>
									</xsl:if>
									<xsl:if
										test="./instanceData/TXLife/A_ProducerSignatureOK = '0'">
										<AppWritingAgentSignatureOK tc="0">False
										</AppWritingAgentSignatureOK>
									</xsl:if>
									<xsl:if
										test="./instanceData/TXLife/A_ProducerSignatureOK = '1'">
										<AppWritingAgentSignatureOK tc="1">True
										</AppWritingAgentSignatureOK>
									</xsl:if>
								</xsl:if>
								<xsl:choose>
									<xsl:when
										test="./instanceData/TXLife/A_ChangeExistingPolicyInd_PINS = '1'">
										<ReplacementInd tc="1">True</ReplacementInd>
									</xsl:when>
									<xsl:otherwise>
										<ReplacementInd tc="0">False</ReplacementInd>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:choose>
									<xsl:when
										test="./instanceData/TXLife/A_ReplacementInd_AGT1 = '1'">
										<ProducerReplacementDisclosureInd
											tc="1">True</ProducerReplacementDisclosureInd>
									</xsl:when>
									<xsl:otherwise>
										<ProducerReplacementDisclosureInd
											tc="0">False</ProducerReplacementDisclosureInd>
									</xsl:otherwise>
								</xsl:choose>
								<SignatureInfo id="SignatureInfo_1">
									<SignatureRoleCode tc="18">Owner
									</SignatureRoleCode>
									<xsl:if
										test="./instanceData/TXLife/A_SignatureMethod = '1'">
										<xsl:if
											test="string-length(instanceData/TXLife/A_SignatureDate)>0">
											<SignatureDate>
												<xsl:call-template name="FormatDate">
													<xsl:with-param name="Separator">
														/
													</xsl:with-param>
													<xsl:with-param name="DateString">
														<xsl:value-of
															select="instanceData/TXLife/A_SignatureDate" />
													</xsl:with-param>
												</xsl:call-template>
											</SignatureDate>
										</xsl:if>
									</xsl:if>
									<xsl:if
										test="./instanceData/TXLife/A_SignatureMethod = '1'">
										<SignatureCity>
											<xsl:value-of
												select="instanceData/TXLife/A_SignatureCity" />
										</SignatureCity>
									</xsl:if>
									<xsl:if
										test="./instanceData/TXLife/A_SignatureState != '-1'">
										<SignatureState>
											<xsl:attribute name="tc">
										<xsl:value-of
												select="instanceData/TXLife/A_SignatureState" />
												</xsl:attribute>
											<xsl:value-of
												select="instanceData/TXLife/A_SignatureState_Desc" />
										</SignatureState>
									</xsl:if>
									<!-- Updated by Puja -->
								</SignatureInfo>
								<OLifEExtension
									ExtensionCode="ApplicationInfo 2.8.90" VendorCode="05">
									<ApplicationInfoExtension>
										<xsl:if
											test="./instanceData/TXLife/A_ExistingInsInd_AGT1 = '1'">
											<ProducerOtherInsDisclosureInd
												tc="1">True</ProducerOtherInsDisclosureInd>
										</xsl:if>
										<xsl:if
											test="./instanceData/TXLife/A_ExistingInsInd_AGT1 = '0'">
											<ProducerOtherInsDisclosureInd
												tc="0">False</ProducerOtherInsDisclosureInd>
										</xsl:if>
										<xsl:if
											test="string-length(./instanceData/TXLife/A_WorkItemID) >  0">
											<xsl:choose>
												<xsl:when
													test="contains(instanceData/TXLife/A_WorkItemID ,':')">
													<WorkitemID>
														<xsl:value-of
															select="translate(instanceData/TXLife/A_WorkItemID,':','.')" />
													</WorkitemID>
												</xsl:when>
												<xsl:when
													test="not(contains(instanceData/TXLife/A_WorkItemID ,':'))">
													<WorkitemID>
														<xsl:value-of
															select="instanceData/TXLife/A_WorkItemID" />
													</WorkitemID>
												</xsl:when>
											</xsl:choose>
										</xsl:if>
										<xsl:if
											test="string-length(instanceData/TXLife/A_IllustrationIDNum)>0">
											<IllustrationID>
												<xsl:value-of
													select="instanceData/TXLife/A_IllustrationIDNum" />
											</IllustrationID>
										</xsl:if>
										<xsl:if
											test="string-length(instanceData/TXLife/A_Illustration_Dt)>0">
											<QuoteDate>
												<xsl:call-template name="FormatDate">
													<xsl:with-param name="Separator">
														/
													</xsl:with-param>
													<xsl:with-param name="DateString">
														<xsl:value-of
															select="instanceData/TXLife/A_Illustration_Dt" />
													</xsl:with-param>
												</xsl:call-template>
											</QuoteDate>
										</xsl:if>
										<xsl:if
											test="string-length(instanceData/TXLife/A_Illustration_ExpiryDt)>0">
											<QuoteExpireDt>
												<xsl:call-template name="FormatDate">
													<xsl:with-param name="Separator">
														/
													</xsl:with-param>
													<xsl:with-param name="DateString">
														<xsl:value-of
															select="instanceData/TXLife/A_Illustration_ExpiryDt" />
													</xsl:with-param>
												</xsl:call-template>
											</QuoteExpireDt>
										</xsl:if>
										<xsl:if
											test="./instanceData/TXLife/A_JointOwnerSignatureOK = '0'">
											<JtAppOwnerSignatureOK tc="0">False
											</JtAppOwnerSignatureOK>
										</xsl:if>
										<xsl:if
											test="./instanceData/TXLife/A_JointOwnerSignatureOK = '1'">
											<JtAppOwnerSignatureOK tc="1">True
											</JtAppOwnerSignatureOK>
										</xsl:if>
										<xsl:if
											test="./instanceData/TXLife/A_PISignatureOK = '0'">
											<AnnuitantSignatureOK tc="0">False
											</AnnuitantSignatureOK>
										</xsl:if>
										<xsl:if
											test="./instanceData/TXLife/A_PISignatureOK = '1'">
											<AnnuitantSignatureOK tc="1">True
											</AnnuitantSignatureOK>
										</xsl:if>
										<xsl:if
											test="./instanceData/TXLife/A_JointAnnSignatureOK = '0'">
											<JtAnnuitantSignatureOK tc="0">False
											</JtAnnuitantSignatureOK>
										</xsl:if>
										<xsl:if
											test="./instanceData/TXLife/A_JointAnnSignatureOK = '1'">
											<JtAnnuitantSignatureOK tc="1">True
											</JtAnnuitantSignatureOK>
										</xsl:if>
									</ApplicationInfoExtension>
								</OLifEExtension>
							</ApplicationInfo>
							<OLifEExtension ExtensionCode="Policy 2.8.90"
								VendorCode="05">
								<PolicyExtension>
									<xsl:if test="./instanceData/TXLife/A_EDElected = '1'">
										<AuthElectDocDelivery tc="1">True
										</AuthElectDocDelivery>
									</xsl:if>
									<xsl:if test="./instanceData/TXLife/A_EDElected != '1'">
										<AuthElectDocDelivery tc="0">False
										</AuthElectDocDelivery>
									</xsl:if>
									<xsl:choose>
										<xsl:when
											test="contains(instanceData/TXLife/A_PrevAccValue_DecedentIRA ,'$')">
											<Prior-12-31-ACV>
												<xsl:value-of
													select="translate(substring-after(instanceData/TXLife/A_PrevAccValue_DecedentIRA, '$'),',','')" />
											</Prior-12-31-ACV>
										</xsl:when>
										<xsl:when
											test="not(contains(instanceData/TXLife/A_PrevAccValue_DecedentIRA ,'$'))">
											<Prior-12-31-ACV>
												<xsl:value-of
													select="translate(instanceData/TXLife/A_PrevAccValue_DecedentIRA,',','')" />
											</Prior-12-31-ACV>
										</xsl:when>
									</xsl:choose>
								</PolicyExtension>
							</OLifEExtension>
						</Policy>
						<Investment>
							<xsl:for-each select="instanceData/TXLife/*">
								<xsl:if test="starts-with(name(),'A_AllocPercent_')">
									<xsl:if test="string-length(.) > 0">
										<xsl:variable name="pos"
											select="substring(name(),16)" />
										<xsl:variable name="posValue"
											select='format-number($pos, "0")' />
										<xsl:if
											test="../*[name()=concat('A_AllocPercent_',$pos)]!='0'">
											<SubAccount>
												<xsl:attribute name="id">
													<xsl:value-of
													select="concat('SubAccount_',$pos)" />
												</xsl:attribute>
												<ProductCode>
													<xsl:value-of select="$pos" />
												</ProductCode>
												<AllocPercent>
													<xsl:value-of
														select="../*[name()=concat('A_AllocPercent_',$pos)]" />
												</AllocPercent>
											</SubAccount>
										</xsl:if>
									</xsl:if>
								</xsl:if>
							</xsl:for-each>
							<xsl:for-each select="instanceData/TXLife/*">
								<xsl:if test="starts-with(name(),'A_AllocPercentDCA_')">
									<xsl:if test="string-length(.) > 0">
										<xsl:variable name="pos"
											select="substring(name(),19)" />
										<xsl:variable name="posValue"
											select='format-number($pos, "0")' />
										<xsl:if
											test="../*[name()=concat('A_AllocPercentDCA_',$pos)]!='0'">
											<SubAccount>
												<xsl:attribute name="id">
														<xsl:value-of
													select="concat('SubAccountDCA_',$pos)" />												
													</xsl:attribute>
												<ProductCode>
													<xsl:value-of select="$pos" />
												</ProductCode>
												<AllocPercent>
													<xsl:value-of
														select="../*[name()=concat('A_AllocPercentDCA_',$pos)]" />
												</AllocPercent>
											</SubAccount>
										</xsl:if>
									</xsl:if>
								</xsl:if>
							</xsl:for-each>
							<!--if Fixed account is not selected in Allocation screen for DCA, 
								then manually creating the sub-account id -->
							<xsl:if test="./instanceData/TXLife/A_DCAEDCA_Type='2'">
								<xsl:variable name="pos">
									<xsl:value-of
										select="instanceData/TXLife/A_DCA_From_Fund" />
								</xsl:variable>
								<xsl:if
									test="not(string-length(instanceData/TXLife/[name()=concat('A_AllocPercent_',$pos)])>0)
							or instanceData/TXLife/[name()=concat('A_AllocPercent_',$pos)] = '0'">
									<SubAccount>
										<xsl:attribute name="id"><xsl:value-of
											select="concat('SubAccount_',$pos)" /></xsl:attribute>
										<ProductCode>
											<xsl:value-of select="$pos" />
										</ProductCode>
									</SubAccount>
								</xsl:if>
							</xsl:if>
						</Investment>
						<Arrangement id="Arrangment_1">
							<ArrType tc="37">Premium Allocation</ArrType>
							<xsl:for-each select="instanceData/TXLife/*">
								<xsl:if test="starts-with(name(),'A_AllocPercent_')">
									<xsl:if test="string-length(.) > 0">
										<xsl:variable name="pos"
											select="substring(name(),16)" />
										<xsl:variable name="posValue"
											select='format-number($pos, "0")' />
										<xsl:if
											test="../*[name()=concat('A_AllocPercent_',$pos)]!='0'">
											<ArrDestination>
												<xsl:attribute name="id">
													<xsl:value-of
													select="concat('ArrDestination_',$pos)" />
												</xsl:attribute>
												<xsl:attribute name="SubAcctID">
													<xsl:value-of
													select="concat('SubAccount_',$pos)" />
												</xsl:attribute>
												<TransferAmtType tc="3">Percent
												</TransferAmtType>
												<TransferPct>
													<xsl:value-of
														select="../*[name()=concat('A_AllocPercent_',$pos)]" />
												</TransferPct>
											</ArrDestination>
										</xsl:if>
									</xsl:if>
								</xsl:if>
							</xsl:for-each>
						</Arrangement>
						<xsl:if
							test="./instanceData/TXLife/A_DCAEDCA_Type != '1' and string-length(instanceData/TXLife/A_DCAEDCA_Type)>0">
							<Arrangement id="Arrangment_DCA_EDCA">
								<ArrType>
									<xsl:attribute name="tc"><xsl:value-of
										select="instanceData/TXLife/A_DCAEDCA_Type" /></xsl:attribute>
									<xsl:value-of
										select="instanceData/TXLife/A_DCAEDCA_Type_Desc" />
								</ArrType>
								<ArrSource id="ArrSource_1">
									<xsl:attribute name="SubAcctID"><xsl:value-of
										select="concat('SubAccount_',instanceData/TXLife/A_DCA_From_Fund)" />
									</xsl:attribute>
									<TransferAmtType tc="2">Amounts</TransferAmtType>
									<xsl:choose>
										<xsl:when
											test="contains(instanceData/TXLife/A_DCA_Amount,'$')">
											<TransferAmt>
												<xsl:value-of
													select="translate(substring-after(instanceData/TXLife/A_DCA_Amount, '$'),',','')" />
											</TransferAmt>
										</xsl:when>
										<xsl:when
											test="not(contains(instanceData/TXLife/A_DCA_Amount,'$'))">
											<TransferAmt>
												<xsl:value-of
													select="translate(instanceData/TXLife/A_DCA_Amount,',','')" />
											</TransferAmt>
										</xsl:when>
									</xsl:choose>
								</ArrSource>
								<xsl:for-each select="instanceData/TXLife/*">
									<xsl:if test="starts-with(name(),'A_AllocPercentDCA_')">
										<xsl:if test="string-length(.) > 0">
											<xsl:variable name="pos"
												select="substring(name(),19)" />
											<xsl:variable name="posValue"
												select='format-number($pos, "0")' />
											<xsl:if
												test="../*[name()=concat('A_AllocPercentDCA_',$pos)]!='0'">
												<ArrDestination>
													<xsl:attribute name="id">
															<xsl:value-of
														select="concat('ArrDestinationDCA_',$pos)" />												
														</xsl:attribute>
													<xsl:attribute name="SubAcctID">
															<xsl:value-of
														select="concat('SubAccountDCA_',$pos)" />												
														</xsl:attribute>
													<TransferAmtType tc="3">Percent
													</TransferAmtType>
													<TransferPct>
														<xsl:value-of
															select="../*[name()=concat('A_AllocPercentDCA_',$pos)]" />
													</TransferPct>
												</ArrDestination>
											</xsl:if>
										</xsl:if>
									</xsl:if>
								</xsl:for-each>
								<OLifEExtension VendorCode="05"
									ExtensionCode="Arrangement 2.8.90">
									<ArrangementExtension>
										<TransferNumberTC>
											<xsl:attribute name="tc"><xsl:value-of
												select="instanceData/TXLife/A_DCA_Period" /></xsl:attribute>
											<xsl:value-of
												select="instanceData/TXLife/A_DCA_Period_Desc" />
										</TransferNumberTC>
										<TransferNumber>
											<xsl:value-of
												select="instanceData/TXLife/A_DCA_Period_Other" />
										</TransferNumber>
									</ArrangementExtension>
								</OLifEExtension>
							</Arrangement>
						</xsl:if>
						<xsl:if test="./instanceData/TXLife/A_Rebalancing_Ind= '3'">
							<Arrangement id="Arrangment_Rebalancing">
								<ArrMod>
									<xsl:attribute name="tc"><xsl:value-of
										select="instanceData/TXLife/A_Rebalancing_Freq" /></xsl:attribute>
									<xsl:value-of
										select="instanceData/TXLife/A_Rebalancing_Freq_Desc" />
								</ArrMod>
								<ArrType tc="3">Rebalancing</ArrType>
							</Arrangement>
						</xsl:if>
						<xsl:if test="./instanceData/TXLife/A_CashWithAppInd= '1'">
							<Banking id="Banking_1">
								<BankAcctType>
									<xsl:attribute name="tc">
										<xsl:value-of
										select="instanceData/TXLife/A_AccountType" />
									</xsl:attribute>
									<xsl:value-of
										select="instanceData/TXLife/A_AccountType_Desc" />
								</BankAcctType>
								<AccountNumber>
									<xsl:value-of
										select="instanceData/TXLife/A_AccountNo" />
								</AccountNumber>
								<RoutingNum>
									<xsl:value-of
										select="instanceData/TXLife/A_RoutingNo" />
								</RoutingNum>
								<OLifEExtension VendorCode="05"
									ExtensionCode="Banking 2.8.90">
									<BankingExtension>
										<xsl:if
											test="./instanceData/TXLife/A_PremPayor != '-1'">
											<AccountHolderNameCC>
												<xsl:if
													test="./instanceData/TXLife/A_PremPayor != '-1'">
													<xsl:if
														test="./instanceData/TXLife/A_PremPayor = '3'">
														<AccountHolderName>
															<xsl:value-of
																select="instanceData/TXLife/A_EntityName_OWN" />
															<xsl:if
																test="./instanceData/TXLife/A_Prefix_OWN != '-1' or string-length(instanceData/TXLife/A_FirstName_OWN)>0 or string-length(instanceData/TXLife/A_MiddleName_OWN)>0 or string-length(instanceData/TXLife/A_LastName_OWN)>0 or ./instanceData/TXLife/A_Suffix_OWN != '-1'">
																<xsl:value-of
																	select="concat(instanceData/TXLife/A_Prefix_OWN_Desc,' ',instanceData/TXLife/A_FirstName_OWN,' ',instanceData/TXLife/A_MiddleName_OWN,' ',instanceData/TXLife/A_LastName_OWN,' ',instanceData/TXLife/A_Suffix_OWN_Desc)" />
															</xsl:if>
														</AccountHolderName>
													</xsl:if>
													<xsl:if
														test="./instanceData/TXLife/A_PremPayor = '4'">
														<AccountHolderName>
															<xsl:if
																test="./instanceData/TXLife/A_Prefix_JointOwn != '-1' or string-length(instanceData/TXLife/A_FirstName_JointOwn)>0 or string-length(instanceData/TXLife/A_MiddleName_JointOwn)>0 or string-length(instanceData/TXLife/A_LastName_JointOwn)>0 or ./instanceData/TXLife/A_Suffix_JointOwn != '-1'">
																<xsl:value-of
																	select="concat(instanceData/TXLife/A_Prefix_JointOwn_Desc,' ',instanceData/TXLife/A_FirstName_JointOwn,' ',instanceData/TXLife/A_MiddleName_JointOwn,' ',instanceData/TXLife/A_LastName_JointOwn,' ',instanceData/TXLife/A_Suffix_JointOwn_Desc)" />
															</xsl:if>
														</AccountHolderName>
													</xsl:if>
													<xsl:if
														test="./instanceData/TXLife/A_PremPayor = '5'">
														<AccountHolderName>
															<xsl:value-of
																select="instanceData/TXLife/A_EntityName_PYR" />
															<xsl:if
																test="./instanceData/TXLife/A_Prefix_PYR != '-1' or string-length(instanceData/TXLife/A_FirstName_PYR)>0 or string-length(instanceData/TXLife/A_MiddleName_PYR)>0 or string-length(instanceData/TXLife/A_LastName_PYR)>0 or ./instanceData/TXLife/A_Suffix_PYR != '-1'">
																<xsl:value-of
																	select="concat(instanceData/TXLife/A_Prefix_PYR_Desc,' ',instanceData/TXLife/A_FirstName_PYR,' ',instanceData/TXLife/A_MiddleName_PYR,' ',instanceData/TXLife/A_LastName_PYR,' ',instanceData/TXLife/A_Suffix_PYR_Desc)" />
															</xsl:if>
														</AccountHolderName>
													</xsl:if>
													<xsl:if
														test="./instanceData/TXLife/A_PremPayor = '1'">
														<AccountHolderName>
															<xsl:if
																test="./instanceData/TXLife/A_Prefix_PINS != '-1' or string-length(instanceData/TXLife/A_FirstName_PINS)>0 or string-length(instanceData/TXLife/A_MiddleName_PINS)>0 or string-length(instanceData/TXLife/A_LastName_PINS)>0 or ./instanceData/TXLife/A_Suffix_PINS != '-1'">
																<xsl:value-of
																	select="concat(instanceData/TXLife/A_Prefix_PINS_Desc,' ',instanceData/TXLife/A_FirstName_PINS,' ',instanceData/TXLife/A_MiddleName_PINS,' ',instanceData/TXLife/A_LastName_PINS,' ',instanceData/TXLife/A_Suffix_PINS_Desc)" />
															</xsl:if>
														</AccountHolderName>
													</xsl:if>
													<xsl:if
														test="./instanceData/TXLife/A_PremPayor = '2'">
														<AccountHolderName>
															<xsl:if
																test="./instanceData/TXLife/A_Prefix_JNT != '-1' or string-length(instanceData/TXLife/A_FirstName_JNT)>0 or string-length(instanceData/TXLife/A_MiddleName_JNT)>0 or string-length(instanceData/TXLife/A_LastName_JNT)>0 or ./instanceData/TXLife/A_Suffix_JNT != '-1'">
																<xsl:value-of
																	select="concat(instanceData/TXLife/A_Prefix_JNT_Desc,' ',instanceData/TXLife/A_FirstName_JNT,' ',instanceData/TXLife/A_MiddleName_JNT,' ',instanceData/TXLife/A_LastName_JNT,' ',instanceData/TXLife/A_Suffix_JNT_Desc)" />
															</xsl:if>
														</AccountHolderName>
													</xsl:if>
												</xsl:if>
											</AccountHolderNameCC>
										</xsl:if>
										<!-- Branchname is not required in Annuity -->
										<!-- <BankBranchName> <xsl:value-of select="instanceData/TXLife/A_BranchName" 
											/> </BankBranchName> -->
										<BankName>
											<xsl:value-of
												select="instanceData/TXLife/A_BankName" />
										</BankName>
										<xsl:if test="./instanceData/TXLife/A_PremPayor = '5'">
											<xsl:if
												test="./instanceData/TXLife/A_RelToPI_PYR!='-1'">
												<AccountHolderRelation>
													<xsl:attribute name="tc">
														<xsl:value-of
														select="instanceData/TXLife/A_RelToPI_PYR" />
													</xsl:attribute>
													<xsl:value-of
														select="instanceData/TXLife/A_RelToPI_PYR_Desc" />
												</AccountHolderRelation>
											</xsl:if>
										</xsl:if>
									</BankingExtension>
								</OLifEExtension>
							</Banking>
						</xsl:if>
					</Holding>
					<!-- NB Holding END -->
					<!--Deseased Owner Holding -->
					<xsl:if
						test="./instanceData/TXLife/A_ContractAppliedFor='100990001' or ./instanceData/TXLife/A_ContractAppliedFor='100990002'">
						<xsl:if
							test="string-length(./instanceData/TXLife/A_CurrentCompany_DecedentIRA_Desc)>0 and
											./instanceData/TXLife/A_CurrentCompany_DecedentIRA !='-1'">
							<Holding id="Holding_DeceasedOwner">
								<HoldingTypeCode tc="2">Policy</HoldingTypeCode>
								<HoldingStatus tc="1">Active</HoldingStatus>
								<Policy>
									<xsl:if
										test="string-length(./instanceData/TXLife/A_PolNum_DecedentIRA)>0">
										<PolNumber>
											<xsl:value-of
												select="./instanceData/TXLife/A_PolNum_DecedentIRA" />
										</PolNumber>
									</xsl:if>
									<xsl:choose>
										<xsl:when
											test="contains(./instanceData/TXLife/A_CurrentCompany_DecedentIRA_Desc,'Brighthouse') or
																      contains(./instanceData/TXLife/A_CurrentCompany_DecedentIRA_Desc,'MetLife') or 
																      contains(./instanceData/TXLife/A_CurrentCompany_DecedentIRA_Desc,'New England Financial') or
																      contains(./instanceData/TXLife/A_CurrentCompany_DecedentIRA_Desc,'Security First Life Ins Co')">
											<ReplacementType tc="2">Internal
											</ReplacementType>
										</xsl:when>
										<xsl:otherwise>
											<ReplacementType tc="3">External
											</ReplacementType>
										</xsl:otherwise>
									</xsl:choose>
								</Policy>
							</Holding>
						</xsl:if>
						<xsl:if
							test="string-length(./instanceData/TXLife/A_CurrentCompany_DecedentIRA_Desc)>0">
							<Party id="Party_Decedent_CAR">
								<PartyTypeCode tc="2">Organization</PartyTypeCode>
								<FullName>
									<xsl:value-of
										select="./instanceData/TXLife/A_CurrentCompany_DecedentIRA_Desc" />
								</FullName>
								<Organization>
									<DBA>
										<xsl:value-of
											select="./instanceData/TXLife/A_CurrentCompany_DecedentIRA_Desc" />
									</DBA>
								</Organization>
							</Party>
						</xsl:if>
						<xsl:if
							test="string-length(./instanceData/TXLife/A_FirstName_DecedentIRA)>0 
										or string-length(./instanceData/TXLife/A_LastName_DecedentIRA)>0 ">
							<Party id="Party_DeceasedOwner">
								<PartyTypeCode tc="1">Person</PartyTypeCode>
								<xsl:if
									test="string-length(./instanceData/TXLife/A_GovtID_SSN_DecedentIRA)>0">
									<GovtID>
										<xsl:value-of
											select="translate(./instanceData/TXLife/A_GovtID_SSN_DecedentIRA,'-','')" />
									</GovtID>
									<GovtIDTC tc="1">Social Security Number</GovtIDTC>
								</xsl:if>
								<Person>
									<FirstName>
										<xsl:value-of
											select="./instanceData/TXLife/A_FirstName_DecedentIRA" />
									</FirstName>
									<MiddleName>
										<xsl:value-of
											select="./instanceData/TXLife/A_MiddleName_DecedentIRA" />
									</MiddleName>
									<LastName>
										<xsl:value-of
											select="./instanceData/TXLife/A_LastName_DecedentIRA" />
									</LastName>
									<xsl:if
										test="./instanceData/TXLife/A_Prefix_DecedentIRA != '-1'">
										<Prefix>
											<xsl:value-of
												select="./instanceData/TXLife/A_Prefix_DecedentIRA" />
										</Prefix>
									</xsl:if>
									<xsl:if
										test="./instanceData/TXLife/A_Suffix_DecedentIRA != '-1'">
										<Suffix>
											<xsl:value-of
												select="./instanceData/TXLife/A_Suffix_DecedentIRA" />
										</Suffix>
									</xsl:if>
									<xsl:if
										test="string-length(./instanceData/TXLife/A_DOB_DecedentIRA)>0">
										<BirthDate>
											<xsl:value-of
												select="instanceData/TXLife/A_DOB_DecedentIRA" />
										</BirthDate>
									</xsl:if>
									<xsl:if
										test="string-length(./instanceData/TXLife/A_DOD_DecedentIRA)>0">
										<EstMortalityDate>
											<xsl:value-of
												select="instanceData/TXLife/A_DOD_DecedentIRA" />
										</EstMortalityDate>
									</xsl:if>
								</Person>
							</Party>
						</xsl:if>
					</xsl:if>
					<!-- Deseased Owner Holding END -->
					<!-- Replacment Holding START -->
					<xsl:if
						test="./instanceData/TXLife/A_ChangeExistingPolicyInd_PINS='1'">
						<xsl:for-each select="instanceData/TXLife/*">
							<xsl:if test="starts-with(name(),'A_PolNum_REP')">
								<xsl:variable name="pos"
									select="substring(name(),13)" />
								<xsl:variable name="repCount"
									select='format-number(../*[name()="A_COUNT_TOTAL_REP"], 	"0")' />
								<xsl:variable name="posValue"
									select='format-number($pos, "0")' />
								<xsl:if test="$pos != '' and $posValue &lt;= $repCount">
									<xsl:if
										test="string-length(../*[name()=concat('A_ReplacementCompany_REP',$pos)])>0 and
											../*[name()=concat('A_ReplacementCompany_REP',$pos)]!='-1'">
										<Holding>
											<xsl:attribute name="id">
													<xsl:value-of
												select="concat('Holding_REP_',$pos)" />
												</xsl:attribute>
											<HoldingTypeCode tc="2">Policy</HoldingTypeCode>
											<HoldingStatus tc="1">Active</HoldingStatus>
											<Policy>
												<xsl:if
													test="string-length(../*[name()=concat('A_PolNum_REP',$pos)])>0">
													<PolNumber>
														<xsl:value-of
															select="../*[name()=concat('A_PolNum_REP',$pos)]" />
													</PolNumber>
												</xsl:if>
												<!-- BHFD-1171 -->
												<!-- <xsl:if test="string-length(../*[name()=concat('A_PlanType_REP',$pos,'_Desc')])>0"> 
													<ProductCode> <xsl:value-of select="../*[name()=concat('A_PlanType_REP',$pos, 
													'_Desc')]" /> </ProductCode> </xsl:if> -->
												<xsl:choose>
													<xsl:when
														test="contains(../*[name()=concat('A_ReplacementCompany_REP',$pos,'_Desc')] ,'Brighthouse') or
																      contains(../*[name()=concat('A_ReplacementCompany_REP',$pos,'_Desc')] ,'MetLife') or 
																      contains(../*[name()=concat('A_ReplacementCompany_REP',$pos,'_Desc')] ,'New England Financial') or
																      contains(../*[name()=concat('A_ReplacementCompany_REP',$pos,'_Desc')] ,'Security First Life Ins Co')">
														<ReplacementType tc="2">Internal
														</ReplacementType>
													</xsl:when>
													<xsl:otherwise>
														<ReplacementType tc="3">External
														</ReplacementType>
													</xsl:otherwise>
												</xsl:choose>
											</Policy>
										</Holding>
									</xsl:if>
									<xsl:if
										test="string-length(../*[name()=concat('A_ReplacementCompany_REP',$pos,'_Desc')])>0">
										<Party>
											<xsl:attribute name="id">
												<xsl:value-of
												select="concat('Party_REP',$pos,'_CAR')" />
											</xsl:attribute>
											<PartyTypeCode tc="2">Organization</PartyTypeCode>
											<FullName>
												<xsl:value-of
													select="../*[name()=concat('A_ReplacementCompany_REP',$pos,'_Desc')]" />
											</FullName>
											<Organization>
												<DBA>
													<xsl:value-of
														select="../*[name()=concat('A_ReplacementCompany_REP',$pos,'_Desc')]" />
												</DBA>
											</Organization>
										</Party>
									</xsl:if>
									<!-- <xsl:if test="string-length(../*[name()=concat('A_LastName_REP',$pos)])>0 
										or string-length(../*[name()=concat('A_FirstName_REP',$pos)])>0 "> <Party> 
										<xsl:attribute name="id"> <xsl:value-of select="concat('Party_REP',$pos,'_INS')" 
										/> </xsl:attribute> <PartyTypeCode tc="1">Person</PartyTypeCode> <Person> 
										<FirstName> <xsl:value-of select="../*[name()=concat('A_FirstName_REP',$pos)]" 
										/> </FirstName> <MiddleName> <xsl:value-of select="../*[name()=concat('A_MiddleName_REP',$pos)]" 
										/> </MiddleName> <LastName> <xsl:value-of select="../*[name()=concat('A_LastName_REP',$pos)]" 
										/> </LastName> <xsl:if test="../*[name()=concat('A_Prefix_REP',$pos)] != 
										'-1'"> <Prefix> <xsl:value-of select="../*[name()=concat('A_Prefix_REP',$pos)]" 
										/> </Prefix> </xsl:if> <xsl:if test="../*[name()=concat('A_Suffix_REP',$pos)] 
										!= '-1'"> <Suffix> <xsl:value-of select="../*[name()=concat('A_Suffix_REP',$pos)]" 
										/> </Suffix> </xsl:if> </Person> </Party> </xsl:if> -->
								</xsl:if>
							</xsl:if>
						</xsl:for-each>
					</xsl:if>
					<!-- Replacment Holding END -->
					<!-- Annuitant Party START -->
					<xsl:if
						test="string-length(./instanceData/TXLife/A_FirstName_PINS)>0 or string-length(./instanceData/TXLife/A_LastName_PINS)>0 ">
						<Party id="Party_PINS">
							<PartyTypeCode tc="1">Person</PartyTypeCode>
							<xsl:if
								test="string-length(./instanceData/TXLife/A_GovtID_SSN_PINS)>0">
								<GovtID>
									<xsl:value-of
										select="translate(./instanceData/TXLife/A_GovtID_SSN_PINS,'-','')" />
								</GovtID>
								<GovtIDTC tc="1">Social Security Number</GovtIDTC>
							</xsl:if>
							<xsl:if test="./instanceData/TXLife/A_State_PINS !=  '-1'">
								<ResidenceState>
									<xsl:attribute name="tc">
											<xsl:value-of
										select="instanceData/TXLife/A_State_PINS" />
										</xsl:attribute>
									<xsl:value-of
										select="instanceData/TXLife/A_State_PINS_Desc" />
								</ResidenceState>
							</xsl:if>
							<xsl:if
								test="./instanceData/A_ResidencyCountry_PINS !=  '-1'">
								<ResidenceCountry>
									<xsl:attribute name="tc">
											<xsl:value-of
										select="instanceData/TXLife/A_ResidencyCountry_PINS" />
										</xsl:attribute>
									<xsl:value-of
										select="instanceData/A_ResidencyCountry_PINS_Desc" />
								</ResidenceCountry>
							</xsl:if>
							<Person>
								<FirstName>
									<xsl:value-of
										select="instanceData/TXLife/A_FirstName_PINS" />
								</FirstName>
								<xsl:if
									test="string-length(./instanceData/TXLife/A_MiddleName_PINS)>0">
									<MiddleName>
										<xsl:value-of
											select="instanceData/TXLife/A_MiddleName_PINS" />
									</MiddleName>
								</xsl:if>
								<LastName>
									<xsl:value-of
										select="instanceData/TXLife/A_LastName_PINS" />
								</LastName>
								<xsl:if
									test="./instanceData/TXLife/A_Prefix_PINS != '-1'">
									<Prefix>
										<xsl:value-of
											select="instanceData/TXLife/A_Prefix_PINS" />
									</Prefix>
								</xsl:if>
								<xsl:if
									test="./instanceData/TXLife/A_Suffix_PINS != '-1'">
									<Suffix>
										<xsl:value-of
											select="instanceData/TXLife/A_Suffix_PINS" />
									</Suffix>
								</xsl:if>
								<Gender>
									<xsl:attribute name="tc">
										<xsl:value-of
										select="instanceData/TXLife/A_Gender_PINS" />
									</xsl:attribute>
									<xsl:value-of
										select="instanceData/TXLife/A_Gender_PINS_Desc" />
								</Gender>
								<BirthDate>
									<xsl:value-of
										select="instanceData/TXLife/A_DOB_PINS" />
								</BirthDate>
								<xsl:if
									test="./instanceData/TXLife/A_Citizenship_PINS != '-1'">
									<Citizenship>
										<xsl:attribute name="tc">
											<xsl:value-of
											select="instanceData/TXLife/A_Citizenship_PINS" />
										</xsl:attribute>
										<xsl:value-of
											select="instanceData/TXLife/A_Citizenship_PINS_Desc" />
									</Citizenship>
								</xsl:if>
							</Person>
							<Address id="Address_PINS">
								<AddressTypeCode tc="1">Home</AddressTypeCode>
								<Line1>
									<xsl:value-of
										select="instanceData/TXLife/A_AddressLine1_PINS" />
								</Line1>
								<Line2>
									<xsl:value-of
										select="instanceData/TXLife/A_AddressLine2_PINS" />
								</Line2>
								<Line3>
									<xsl:value-of
										select="instanceData/TXLife/A_AddressLine3_PINS" />
								</Line3>
								<Line4>
									<xsl:value-of
										select="instanceData/TXLife/A_AddressLine4_PINS" />
								</Line4>
								<City>
									<xsl:value-of
										select="instanceData/TXLife/A_City_PINS" />
								</City>
								<AddressStateTC>
									<xsl:attribute name="tc">
										<xsl:value-of
										select="instanceData/TXLife/A_State_PINS" />
									</xsl:attribute>
									<xsl:value-of
										select="instanceData/TXLife/A_State_PINS_Desc" />
								</AddressStateTC>
								<xsl:choose>
									<xsl:when
										test="contains(instanceData/TXLife/A_ZipCode_PINS ,'-')">
										<Zip>
											<xsl:value-of
												select="translate(instanceData/TXLife/A_ZipCode_PINS,'-','')" />
										</Zip>
									</xsl:when>
									<xsl:when
										test="not(contains(instanceData/TXLife/A_ZipCode_PINS ,'-'))">
										<Zip>
											<xsl:value-of
												select="instanceData/TXLife/A_ZipCode_PINS" />
										</Zip>
									</xsl:when>
								</xsl:choose>
								<AddressCountryTC>
									<xsl:attribute name="tc">
										<xsl:value-of
										select="instanceData/TXLife/A_Country_PINS" />
									</xsl:attribute>
									<xsl:value-of
										select="instanceData/TXLife/A_Country_PINS_Desc" />
								</AddressCountryTC>
							</Address>
							<xsl:if
								test="string-length(./instanceData/TXLife/A_PhoneNum_PINS)	>  0">
								<Phone id="Phone1_PINS">
									<PhoneTypeCode tc="1">Home</PhoneTypeCode>
									<AreaCode>
										<xsl:value-of
											select="substring(./instanceData/TXLife/A_PhoneNum_PINS,1,3)" />
									</AreaCode>
									<DialNumber>
										<xsl:value-of
											select="substring(./instanceData/TXLife/A_PhoneNum_PINS,4)" />
									</DialNumber>
								</Phone>
							</xsl:if>
							<xsl:if
								test="string-length(./instanceData/TXLife/A_EmailAddress_PINS)	>  0">
								<EMailAddress id="EMailAddress_PINS">
									<EMailType tc="2">Personal</EMailType>
									<AddrLine>
										<xsl:value-of
											select="instanceData/TXLife/A_EmailAddress_PINS" />
									</AddrLine>
								</EMailAddress>
							</xsl:if>
						</Party>
					</xsl:if>
					<!-- Annuitant Party END -->
					<!-- Joint Annuitant Party START -->
					<xsl:if
						test="./instanceData/A_JointAnnInd =  '1' and 
						(string-length(./instanceData/TXLife/A_FirstName_JNT)>0 or string-length(./instanceData/TXLife/A_LastName_JNT)>0) ">
						<Party id="Party_JNT">
							<PartyTypeCode tc="1">Person</PartyTypeCode>
							<xsl:if
								test="string-length(./instanceData/TXLife/A_GovtID_SSN_JNT)>0">
								<GovtID>
									<xsl:value-of
										select="translate(./instanceData/TXLife/A_GovtID_SSN_JNT,'-','')" />
								</GovtID>
								<GovtIDTC tc="1">Social Security Number</GovtIDTC>
							</xsl:if>
							<xsl:if test="./instanceData/TXLife/A_State_JNT !=  '-1'">
								<ResidenceState>
									<xsl:attribute name="tc">
											<xsl:value-of
										select="instanceData/TXLife/A_State_JNT" />
										</xsl:attribute>
									<xsl:value-of
										select="instanceData/TXLife/A_State_JNT_Desc" />
								</ResidenceState>
							</xsl:if>
							<xsl:if
								test="./instanceData/A_ResidencyCountry_JNT !=  '-1'">
								<ResidenceCountry>
									<xsl:attribute name="tc">
											<xsl:value-of
										select="instanceData/TXLife/A_ResidencyCountry_JNT" />
										</xsl:attribute>
									<xsl:value-of
										select="instanceData/A_ResidencyCountry_JNT_Desc" />
								</ResidenceCountry>
							</xsl:if>
							<Person>
								<FirstName>
									<xsl:value-of
										select="instanceData/TXLife/A_FirstName_JNT" />
								</FirstName>
								<xsl:if
									test="string-length(./instanceData/TXLife/A_MiddleName_JNT)>0">
									<MiddleName>
										<xsl:value-of
											select="instanceData/TXLife/A_MiddleName_JNT" />
									</MiddleName>
								</xsl:if>
								<LastName>
									<xsl:value-of
										select="instanceData/TXLife/A_LastName_JNT" />
								</LastName>
								<xsl:if test="./instanceData/TXLife/A_Prefix_JNT != '-1'">
									<Prefix>
										<xsl:value-of
											select="instanceData/TXLife/A_Prefix_JNT" />
									</Prefix>
								</xsl:if>
								<xsl:if test="./instanceData/TXLife/A_Suffix_JNT != '-1'">
									<Suffix>
										<xsl:value-of
											select="instanceData/TXLife/A_Suffix_JNT" />
									</Suffix>
								</xsl:if>
								<Gender>
									<xsl:attribute name="tc">
										<xsl:value-of
										select="instanceData/TXLife/A_Gender_JNT" />
									</xsl:attribute>
									<xsl:value-of
										select="instanceData/TXLife/A_Gender_JNT_Desc" />
								</Gender>
								<BirthDate>
									<xsl:value-of
										select="instanceData/TXLife/A_DOB_JNT" />
								</BirthDate>
								<xsl:if
									test="./instanceData/TXLife/A_Citizenship_JNT != '-1'">
									<Citizenship>
										<xsl:attribute name="tc">
											<xsl:value-of
											select="instanceData/TXLife/A_Citizenship_JNT" />
										</xsl:attribute>
										<xsl:value-of
											select="instanceData/TXLife/A_Citizenship_JNT_Desc" />
									</Citizenship>
								</xsl:if>
							</Person>
							<Address id="Address_JNT">
								<AddressTypeCode tc="1">Home</AddressTypeCode>
								<Line1>
									<xsl:value-of
										select="instanceData/TXLife/A_AddressLine1_JNT" />
								</Line1>
								<Line2>
									<xsl:value-of
										select="instanceData/TXLife/A_AddressLine2_JNT" />
								</Line2>
								<Line3>
									<xsl:value-of
										select="instanceData/TXLife/A_AddressLine3_JNT" />
								</Line3>
								<Line4>
									<xsl:value-of
										select="instanceData/TXLife/A_AddressLine4_JNT" />
								</Line4>
								<City>
									<xsl:value-of
										select="instanceData/TXLife/A_City_JNT" />
								</City>
								<AddressStateTC>
									<xsl:attribute name="tc">
										<xsl:value-of
										select="instanceData/TXLife/A_State_JNT" />
									</xsl:attribute>
									<xsl:value-of
										select="instanceData/TXLife/A_State_JNT_Desc" />
								</AddressStateTC>
								<xsl:choose>
									<xsl:when
										test="contains(instanceData/TXLife/A_ZipCode_JNT ,'-')">
										<Zip>
											<xsl:value-of
												select="translate(instanceData/TXLife/A_ZipCode_JNT,'-','')" />
										</Zip>
									</xsl:when>
									<xsl:when
										test="not(contains(instanceData/TXLife/A_ZipCode_JNT ,'-'))">
										<Zip>
											<xsl:value-of
												select="instanceData/TXLife/A_ZipCode_JNT" />
										</Zip>
									</xsl:when>
								</xsl:choose>
								<AddressCountryTC>
									<xsl:attribute name="tc">
										<xsl:value-of
										select="instanceData/TXLife/A_Country_JNT" />
									</xsl:attribute>
									<xsl:value-of
										select="instanceData/TXLife/A_Country_JNT_Desc" />
								</AddressCountryTC>
							</Address>
							<xsl:if
								test="string-length(./instanceData/TXLife/A_PhoneNum_JNT)	>  0">
								<Phone id="Phone1_JNT">
									<PhoneTypeCode tc="1">Home</PhoneTypeCode>
									<AreaCode>
										<xsl:value-of
											select="substring(./instanceData/TXLife/A_PhoneNum_JNT,1,3)" />
									</AreaCode>
									<DialNumber>
										<xsl:value-of
											select="substring(./instanceData/TXLife/A_PhoneNum_JNT,4)" />
									</DialNumber>
								</Phone>
							</xsl:if>
							<xsl:if
								test="string-length(./instanceData/TXLife/A_EmailAddress_JNT)	>  0">
								<EMailAddress id="EMailAddress_JNT">
									<EMailType tc="2">Personal</EMailType>
									<AddrLine>
										<xsl:value-of
											select="instanceData/TXLife/A_EmailAddress_JNT" />
									</AddrLine>
								</EMailAddress>
							</xsl:if>
						</Party>
					</xsl:if>
					<!-- Joint Annuitant Party END -->
					<!-- Owner Party START -->
					<xsl:if
						test="./instanceData/TXLife/A_OwnerType = '1' and 
											(string-length(./instanceData/TXLife/A_FirstName_OWN) > 0 or 
											string-length(./instanceData/TXLife/A_LastName_OWN) > 0) ">
						<Party id="Party_OWN">
							<PartyTypeCode tc="1">Person</PartyTypeCode>
							<xsl:if
								test="string-length(./instanceData/TXLife/A_GovtID_SSN_OWN) > 0">
								<GovtID>
									<xsl:value-of
										select="translate(./instanceData/TXLife/A_GovtID_SSN_OWN,'-','')" />
								</GovtID>
								<GovtIDTC tc="1">Social Security Number</GovtIDTC>
							</xsl:if>
							<xsl:if
								test="./instanceData/TXLife/A_ResidencyCountry_OWN != '-1'">
								<ResidenceCountry>
									<xsl:attribute name="tc">
																<xsl:value-of
										select="./instanceData/TXLife/A_ResidencyCountry_OWN" />
															</xsl:attribute>
									<xsl:value-of
										select="./instanceData/TXLife/A_ResidencyCountry_OWN_Desc" />
								</ResidenceCountry>
							</xsl:if>
							<Person>
								<FirstName>
									<xsl:value-of
										select="./instanceData/TXLife/A_FirstName_OWN" />
								</FirstName>
								<MiddleName>
									<xsl:value-of
										select="./instanceData/TXLife/A_MiddleName_OWN" />
								</MiddleName>
								<LastName>
									<xsl:value-of
										select="./instanceData/TXLife/A_LastName_OWN" />
								</LastName>
								<xsl:if test="./instanceData/TXLife/A_Prefix_OWN != '-1'">
									<Prefix>
										<xsl:value-of
											select="./instanceData/TXLife/A_Prefix_OWN" />
									</Prefix>
								</xsl:if>
								<xsl:if test="./instanceData/TXLife/A_Suffix_OWN != '-1'">
									<Suffix>
										<xsl:value-of
											select="./instanceData/TXLife/A_Suffix_OWN" />
									</Suffix>
								</xsl:if>
								<xsl:if
									test="string-length(./instanceData/TXLife/A_DOB_OWN) > 0">
									<BirthDate>
										<xsl:call-template name="FormatDate">
											<xsl:with-param name="Separator">
												/
											</xsl:with-param>
											<xsl:with-param name="DateString">
												<xsl:value-of
													select="./instanceData/TXLife/A_DOB_OWN" />
											</xsl:with-param>
										</xsl:call-template>
									</BirthDate>
								</xsl:if>
								<xsl:if
									test="./instanceData/TXLife/A_Citizenship_OWN != '-1'">
									<Citizenship>
										<xsl:attribute name="tc">
																	<xsl:value-of
											select="./instanceData/TXLife/A_Citizenship_OWN" />
																</xsl:attribute>
										<xsl:value-of
											select="./instanceData/TXLife/A_Citizenship_OWN_Desc" />
									</Citizenship>
								</xsl:if>
							</Person>
							<Address id="Address_OWN1">
								<AddressTypeCode tc="1">Home</AddressTypeCode>
								<Line1>
									<xsl:value-of
										select="./instanceData/TXLife/A_AddressLine1_OWN" />
								</Line1>
								<Line2>
									<xsl:value-of
										select="./instanceData/TXLife/A_AddressLine2_OWN" />
								</Line2>
								<Line3>
									<xsl:value-of
										select="./instanceData/TXLife/A_AddressLine3_OWN" />
								</Line3>
								<Line4>
									<xsl:value-of
										select="./instanceData/TXLife/A_AddressLine4_OWN" />
								</Line4>
								<xsl:if
									test="string-length(./instanceData/TXLife/A_City_OWN) > 0">
									<City>
										<xsl:value-of
											select="./instanceData/TXLife/A_City_OWN" />
									</City>
								</xsl:if>
								<xsl:if test="(./instanceData/TXLife/A_State_OWN != '-1'">
									<AddressStateTC>
										<xsl:attribute name="tc">
																	<xsl:value-of
											select="./instanceData/TXLife/A_State_OWN" />
																</xsl:attribute>
										<xsl:value-of
											select="./instanceData/TXLife/A_State_OWN_Desc" />
									</AddressStateTC>
								</xsl:if>
								<xsl:choose>
									<xsl:when
										test="contains(./instanceData/TXLife/A_ZipCode_OWN,'-')">
										<Zip>
											<xsl:value-of
												select="translate(./instanceData/TXLife/A_ZipCode_OWN,'-','')" />
										</Zip>
									</xsl:when>
									<xsl:when
										test="not(contains(./instanceData/TXLife/A_ZipCode_OWN ,'-'))">
										<Zip>
											<xsl:value-of
												select="./instanceData/TXLife/A_ZipCode_OWN" />
										</Zip>
									</xsl:when>
								</xsl:choose>
								<xsl:if
									test="(./instanceData/TXLife/A_Country_OWN != '-1'">
									<AddressCountryTC>
										<xsl:attribute name="tc">
																	<xsl:value-of
											select="./instanceData/TXLife/A_Country_OWN" />
																</xsl:attribute>
										<xsl:value-of
											select="./instanceData/TXLife/A_Country_OWN_Desc" />
									</AddressCountryTC>
								</xsl:if>
							</Address>
							<xsl:if
								test="string-length(./instanceData/TXLife/A_Phone_OWN)>0">
								<Phone id="Phone_OWN1">
									<PhoneTypeCode tc="1">Home</PhoneTypeCode>
									<AreaCode>
										<xsl:value-of
											select="substring(./instanceData/TXLife/A_Phone_OWN,1,3)" />
									</AreaCode>
									<DialNumber>
										<xsl:value-of
											select="substring(./instanceData/TXLife/A_Phone_OWN,4)" />
									</DialNumber>
								</Phone>
							</xsl:if>
							<!-- BHFD-1129 -->
							<xsl:if
								test="string-length(./instanceData/TXLife/A_EmailAddress_OWN) > 0">
								<EMailAddress id="EMailAddress_OWN1">
									<EMailType tc="2">Personal</EMailType>
									<AddrLine>
										<xsl:value-of
											select="./instanceData/TXLife/A_EmailAddress_OWN" />
									</AddrLine>
								</EMailAddress>
							</xsl:if>
						</Party>
					</xsl:if>
					<!-- Entity OWN Party -->
					<xsl:if
						test="./instanceData/TXLife/A_OwnerType = '2' and 
											(string-length(./instanceData/TXLife/A_EntityName_OWN) > 0)">
						<Party id="Party_ENTITY">
							<PartyTypeCode tc="2">Organization</PartyTypeCode>
							<FullName>
								<xsl:value-of
									select="./instanceData/TXLife/A_EntityName_OWN" />
							</FullName>
							<xsl:if
								test="string-length(./instanceData/TXLife/A_GovtID_TID_OWN) > 0">
								<GovtID>
									<xsl:value-of
										select="translate(./instanceData/TXLife/A_GovtID_TID_OWN,'-','')" />
								</GovtID>
								<GovtIDTC tc="2">Taxpayer Identification Number</GovtIDTC>
							</xsl:if>
							<Organization>
								<OrgForm>
									<xsl:attribute name="tc">
																<xsl:value-of
										select="./instanceData/TXLife/A_OwnerType_OWN" />
															</xsl:attribute>
									<xsl:value-of
										select="./instanceData/TXLife/A_OwnerType_OWN_Desc" />
								</OrgForm>
								<xsl:if
									test="./instanceData/TXLife/A_OwnerType_OWN = '16'">
									<EstabDate>
										<xsl:call-template name="FormatDate">
											<xsl:with-param name="Separator">
												/
											</xsl:with-param>
											<xsl:with-param name="DateString">
												<xsl:value-of
													select="./instanceData/TXLife/A_TrustDate_OWN" />
											</xsl:with-param>
										</xsl:call-template>
									</EstabDate>
								</xsl:if>
								<DBA>
									<xsl:value-of
										select="./instanceData/TXLife/A_EntityName_OWN" />
								</DBA>
								<!-- BHFD-576 -->
								<xsl:if
									test="./instanceData/TXLife/A_TrustState_OWN != '-1'">
									<OLifEExtension
										ExtensionCode="Organization 2.8.90" VendorCode="05">
										<OrganizationExtension>
											<TrustState>
												<xsl:attribute name="tc">
																		<xsl:value-of
													select="./instanceData/TXLife/A_TrustState_OWN" />
																	</xsl:attribute>
												<xsl:value-of
													select="./instanceData/TXLife/A_TrustState_OWN_Desc" />
											</TrustState>
										</OrganizationExtension>
									</OLifEExtension>
								</xsl:if>
							</Organization>
							<Address id="Address_OWN1">
								<AddressTypeCode tc="2">Business</AddressTypeCode>
								<Line1>
									<xsl:value-of
										select="./instanceData/TXLife/A_AddressLine1_OWN" />
								</Line1>
								<Line2>
									<xsl:value-of
										select="./instanceData/TXLife/A_AddressLine2_OWN" />
								</Line2>
								<Line3>
									<xsl:value-of
										select="./instanceData/TXLife/A_AddressLine3_OWN" />
								</Line3>
								<Line4>
									<xsl:value-of
										select="./instanceData/TXLife/A_AddressLine4_OWN" />
								</Line4>
								<xsl:if
									test="string-length(./instanceData/TXLife/A_City_OWN) > 0">
									<City>
										<xsl:value-of
											select="./instanceData/TXLife/A_City_OWN" />
									</City>
								</xsl:if>
								<xsl:if test="(./instanceData/TXLife/A_State_OWN != '-1'">
									<AddressStateTC>
										<xsl:attribute name="tc">
																	<xsl:value-of
											select="./instanceData/TXLife/A_State_OWN" />
																</xsl:attribute>
										<xsl:value-of
											select="./instanceData/TXLife/A_State_OWN_Desc" />
									</AddressStateTC>
								</xsl:if>
								<xsl:choose>
									<xsl:when
										test="contains(./instanceData/TXLife/A_ZipCode_OWN,'-')">
										<Zip>
											<xsl:value-of
												select="translate(./instanceData/TXLife/A_ZipCode_OWN,'-','')" />
										</Zip>
									</xsl:when>
									<xsl:when
										test="not(contains(./instanceData/TXLife/A_ZipCode_OWN ,'-'))">
										<Zip>
											<xsl:value-of
												select="./instanceData/TXLife/A_ZipCode_OWN" />
										</Zip>
									</xsl:when>
								</xsl:choose>
								<xsl:if
									test="(./instanceData/TXLife/A_Country_OWN != '-1'">
									<AddressCountryTC>
										<xsl:attribute name="tc">
																	<xsl:value-of
											select="./instanceData/TXLife/A_Country_OWN" />
																</xsl:attribute>
										<xsl:value-of
											select="./instanceData/TXLife/A_Country_OWN_Desc" />
									</AddressCountryTC>
								</xsl:if>
							</Address>
							<xsl:if
								test="string-length(./instanceData/TXLife/A_Phone_OWN)>0">
								<Phone id="Phone_OWN1">
									<PhoneTypeCode tc="2">Business</PhoneTypeCode>
									<AreaCode>
										<xsl:value-of
											select="substring(./instanceData/TXLife/A_Phone_OWN,1,3)" />
									</AreaCode>
									<DialNumber>
										<xsl:value-of
											select="substring(./instanceData/TXLife/A_Phone_OWN,4)" />
									</DialNumber>
								</Phone>
							</xsl:if>
							<!-- BHFD-1129 -->
							<xsl:if
								test="string-length(./instanceData/TXLife/A_EmailAddress_OWN) > 0">
								<EMailAddress id="EMailAddress_OWN1">
									<EMailType tc="1">Business</EMailType>
									<AddrLine>
										<xsl:value-of
											select="./instanceData/TXLife/A_EmailAddress_OWN" />
									</AddrLine>
								</EMailAddress>
							</xsl:if>
						</Party>
					</xsl:if>
					<!-- Entity OWN Party END -->
					<!-- Joint Owner Party START -->
					<xsl:if
						test="./instanceData/TXLife/A_JointOwnInd = '1' and 
											(string-length(./instanceData/TXLife/A_FirstName_JointOwn) > 0 or 
											string-length(./instanceData/TXLife/A_LastName_JointOwn) > 0) ">
						<Party id="Party_JointOwn">
							<PartyTypeCode tc="1">Person</PartyTypeCode>
							<xsl:if
								test="string-length(./instanceData/TXLife/A_GovtID_SSN_JointOwn) > 0">
								<GovtID>
									<xsl:value-of
										select="translate(./instanceData/TXLife/A_GovtID_SSN_JointOwn,'-','')" />
								</GovtID>
								<GovtIDTC tc="1">Social Security Number</GovtIDTC>
							</xsl:if>
							<xsl:if
								test="./instanceData/TXLife/A_ResidencyCountry_JointOwn != '-1'">
								<ResidenceCountry>
									<xsl:attribute name="tc">
																<xsl:value-of
										select="./instanceData/TXLife/A_ResidencyCountry_JointOwn" />
															</xsl:attribute>
									<xsl:value-of
										select="./instanceData/TXLife/A_ResidencyCountry_JointOwn_Desc" />
								</ResidenceCountry>
							</xsl:if>
							<Person>
								<FirstName>
									<xsl:value-of
										select="./instanceData/TXLife/A_FirstName_JointOwn" />
								</FirstName>
								<MiddleName>
									<xsl:value-of
										select="./instanceData/TXLife/A_MiddleName_JointOwn" />
								</MiddleName>
								<LastName>
									<xsl:value-of
										select="./instanceData/TXLife/A_LastName_JointOwn" />
								</LastName>
								<xsl:if
									test="./instanceData/TXLife/A_Prefix_JointOwn != '-1'">
									<Prefix>
										<xsl:value-of
											select="./instanceData/TXLife/A_Prefix_JointOwn" />
									</Prefix>
								</xsl:if>
								<xsl:if
									test="./instanceData/TXLife/A_Suffix_JointOwn != '-1'">
									<Suffix>
										<xsl:value-of
											select="./instanceData/TXLife/A_Suffix_JointOwn" />
									</Suffix>
								</xsl:if>
								<xsl:if
									test="string-length(./instanceData/TXLife/A_DOB_JointOwn) > 0">
									<BirthDate>
										<xsl:call-template name="FormatDate">
											<xsl:with-param name="Separator">
												/
											</xsl:with-param>
											<xsl:with-param name="DateString">
												<xsl:value-of
													select="./instanceData/TXLife/A_DOB_JointOwn" />
											</xsl:with-param>
										</xsl:call-template>
									</BirthDate>
								</xsl:if>
								<xsl:if
									test="./instanceData/TXLife/A_Citizenship_JointOwn != '-1'">
									<Citizenship>
										<xsl:attribute name="tc">
																	<xsl:value-of
											select="./instanceData/TXLife/A_Citizenship_JointOwn" />
																</xsl:attribute>
										<xsl:value-of
											select="./instanceData/TXLife/A_Citizenship_JointOwn_Desc" />
									</Citizenship>
								</xsl:if>
							</Person>
							<Address id="Address_OWN2">
								<AddressTypeCode tc="1">Home</AddressTypeCode>
								<Line1>
									<xsl:value-of
										select="./instanceData/TXLife/A_AddressLine1_JointOwn" />
								</Line1>
								<Line2>
									<xsl:value-of
										select="./instanceData/TXLife/A_AddressLine2_JointOwn" />
								</Line2>
								<Line3>
									<xsl:value-of
										select="./instanceData/TXLife/A_AddressLine3_JointOwn" />
								</Line3>
								<Line4>
									<xsl:value-of
										select="./instanceData/TXLife/A_AddressLine4_JointOwn" />
								</Line4>
								<xsl:if
									test="string-length(./instanceData/TXLife/A_City_JointOwn) > 0">
									<City>
										<xsl:value-of
											select="./instanceData/TXLife/A_City_JointOwn" />
									</City>
								</xsl:if>
								<xsl:if
									test="(./instanceData/TXLife/A_State_JointOwn != '-1'">
									<AddressStateTC>
										<xsl:attribute name="tc">
																	<xsl:value-of
											select="./instanceData/TXLife/A_State_JointOwn" />
																</xsl:attribute>
										<xsl:value-of
											select="./instanceData/TXLife/A_State_JointOwn_Desc" />
									</AddressStateTC>
								</xsl:if>
								<xsl:choose>
									<xsl:when
										test="contains(./instanceData/TXLife/A_ZipCode_JointOwn,'-')">
										<Zip>
											<xsl:value-of
												select="translate(./instanceData/TXLife/A_ZipCode_JointOwn,'-','')" />
										</Zip>
									</xsl:when>
									<xsl:when
										test="not(contains(./instanceData/TXLife/A_ZipCode_JointOwn ,'-'))">
										<Zip>
											<xsl:value-of
												select="./instanceData/TXLife/A_ZipCode_JointOwn" />
										</Zip>
									</xsl:when>
								</xsl:choose>
								<xsl:if
									test="(./instanceData/TXLife/A_Country_JointOwn != '-1'">
									<AddressCountryTC>
										<xsl:attribute name="tc">
																	<xsl:value-of
											select="./instanceData/TXLife/A_Country_JointOwn" />
																</xsl:attribute>
										<xsl:value-of
											select="./instanceData/TXLife/A_Country_JointOwn_Desc" />
									</AddressCountryTC>
								</xsl:if>
							</Address>
							<xsl:if
								test="string-length(./instanceData/TXLife/A_Phone_JointOwn)>0">
								<Phone id="Phone_OWN2">
									<PhoneTypeCode tc="1">Home</PhoneTypeCode>
									<AreaCode>
										<xsl:value-of
											select="substring(./instanceData/TXLife/A_Phone_JointOwn,1,3)" />
									</AreaCode>
									<DialNumber>
										<xsl:value-of
											select="substring(./instanceData/TXLife/A_Phone_JointOwn,4)" />
									</DialNumber>
								</Phone>
							</xsl:if>
							<!-- BHFD-1129 -->
							<xsl:if
								test="string-length(./instanceData/TXLife/A_EmailAddress_JointOwn) > 0">
								<EMailAddress id="EMailAddress_OWN2">
									<EMailType tc="2">Personal</EMailType>
									<AddrLine>
										<xsl:value-of
											select="./instanceData/TXLife/A_EmailAddress_JointOwn" />
									</AddrLine>
								</EMailAddress>
							</xsl:if>
						</Party>
					</xsl:if>
					<!-- Authorized Person For Entity Owner -->
					<xsl:if test="./instanceData/TXLife/A_OwnerType = '2'">
						<xsl:if
							test="string-length(./instanceData/TXLife/A_FirstName_AUTHORIZED)>0 or string-length(./instanceData/TXLife/A_LastName_AUTHORIZED)>0">
							<Party id="Party_AUTHORIZED">
								<PartyTypeCode tc="1">Person</PartyTypeCode>
								<Person>
									<FirstName>
										<xsl:value-of
											select="./instanceData/TXLife/A_FirstName_AUTHORIZED" />
									</FirstName>
									<MiddleName>
										<xsl:value-of
											select="./instanceData/TXLife/A_MiddleName_AUTHORIZED" />
									</MiddleName>
									<LastName>
										<xsl:value-of
											select="./instanceData/TXLife/A_LastName_AUTHORIZED" />
									</LastName>
									<xsl:if
										test="./instanceData/TXLife/A_Prefix_AUTHORIZED != '-1'">
										<Prefix>
											<xsl:value-of
												select="./instanceData/TXLife/A_Prefix_AUTHORIZED" />
										</Prefix>
									</xsl:if>
									<xsl:if
										test="./instanceData/TXLife/A_Suffix_AUTHORIZED != '-1'">
										<Suffix>
											<xsl:value-of
												select="./instanceData/TXLife/A_Suffix_AUTHORIZED" />
										</Suffix>
									</xsl:if>
								</Person>
								<xsl:if
									test="string-length(./instanceData/TXLife/A_Phone_OWN)>0">
									<Phone id="Phone_AUTHORIZED">
										<PhoneTypeCode tc="2">Business</PhoneTypeCode>
										<AreaCode>
											<xsl:value-of
												select="substring(./instanceData/TXLife/A_Phone_OWN,1,3)" />
										</AreaCode>
										<DialNumber>
											<xsl:value-of
												select="substring(./instanceData/TXLife/A_Phone_OWN,4)" />
										</DialNumber>
									</Phone>
								</xsl:if>
								<!-- BHFD-1129 -->
								<xsl:if
									test="string-length(./instanceData/TXLife/A_EmailAddress_OWN) > 0">
									<EMailAddress id="EMailAddress_AUTHORIZED">
										<EMailType tc="1">Business</EMailType>
										<AddrLine>
											<xsl:value-of
												select="./instanceData/TXLife/A_EmailAddress_OWN" />
										</AddrLine>
									</EMailAddress>
								</xsl:if>
							</Party>
						</xsl:if>
					</xsl:if>
					<!-- BEN Party START -->
					<xsl:for-each select="instanceData/TXLife/*">
						<xsl:if test="starts-with(name(),'A_BeneficiaryType_BEN')">
							<xsl:if test="string-length(.) > 0">
								<xsl:variable name="pos"
									select="substring(name(),22)" />
								<xsl:variable name="benValue"
									select='format-number(../*[name()="A_COUNT_TOTAL_BEN"], "0")' />
								<xsl:variable name="posValue"
									select='format-number($pos, "0")' />
								<xsl:if test="$pos != '' and $posValue &lt;= $benValue">
									<xsl:if
										test="../*[name()=concat('A_BeneficiarySameAs_BEN',$pos)] ='-1' and
										(string-length(../*[name()=concat('A_FirstName_BEN',$pos)])> 0 or 
										string-length(../*[name()=concat('A_LastName_BEN',$pos)])> 0 or 
										string-length(../*[name()=concat('A_EntityName_BEN',$pos)])> 0) ">
										<Party>
											<xsl:attribute name="id">
												<xsl:value-of
												select="concat('Party_BEN',$pos)" />
											</xsl:attribute>
											<PartyTypeCode>
												<xsl:attribute name="tc">
													<xsl:value-of
													select="../*[name()=concat('A_BeneficiaryType_BEN',$pos)]" />
												</xsl:attribute>
												<xsl:value-of
													select="../*[name()=concat('A_BeneficiaryType_BEN',$pos, '_Desc')]" />
											</PartyTypeCode>
											<FullName>
												<xsl:value-of
													select="../*[name()=concat('A_EntityName_BEN',$pos)]" />
											</FullName>
											<xsl:if
												test="../*[name()=concat('A_BeneficiaryType_BEN',$pos)] = '1'">
												<xsl:if
													test="string-length(../*[name()=concat('A_GovtIDSSN_BEN',$pos)])	>  0">
													<GovtID>
														<xsl:value-of
															select="translate(../*[name()=concat('A_GovtIDSSN_BEN',$pos)],'-','')" />
													</GovtID>
													<GovtIDTC tc="1">Social Security Number</GovtIDTC>
												</xsl:if>
											</xsl:if>
											<xsl:if
												test="../*[name()=concat('A_BeneficiaryType_BEN',$pos)] = '2'">
												<xsl:if
													test="string-length(../*[name()=concat('A_GovtIDTID_BEN',$pos)])	>  0">
													<GovtID>
														<xsl:value-of
															select="translate(../*[name()=concat('A_GovtIDTID_BEN',$pos)],'-','')" />
													</GovtID>
													<GovtIDTC tc="2">Taxpayer Identification Number
													</GovtIDTC>
												</xsl:if>
											</xsl:if>
											<Person>
												<FirstName>
													<xsl:value-of
														select="../*[name()=concat('A_FirstName_BEN',$pos)]" />
												</FirstName>
												<MiddleName>
													<xsl:value-of
														select="../*[name()=concat('A_MiddleName_BEN',$pos)]" />
												</MiddleName>
												<LastName>
													<xsl:value-of
														select="../*[name()=concat('A_LastName_BEN',$pos)]" />
												</LastName>
												<xsl:if
													test="../*[name()=concat('A_Prefix_BEN',$pos)] != '-1'">
													<Prefix>
														<xsl:value-of
															select="../*[name()=concat('A_Prefix_BEN',$pos)]" />
													</Prefix>
												</xsl:if>
												<xsl:if
													test="../*[name()=concat('A_Suffix_BEN',$pos)] != '-1'">
													<Suffix>
														<xsl:value-of
															select="../*[name()=concat('A_Suffix_BEN',$pos)]" />
													</Suffix>
												</xsl:if>
												<xsl:if
													test="string-length(../*[name()=concat('A_DOB_BEN',$pos)])	>  0">
													<BirthDate>
														<xsl:value-of
															select="../*[name()=concat('A_DOB_BEN',$pos)]" />
													</BirthDate>
												</xsl:if>
											</Person>
											<Organization>
												<xsl:if
													test="string-length(../*[name()=concat('A_TrustDate_BEN',$pos)]) > ">
													<EstabDate>
														<xsl:value-of
															select="../*[name()=concat('A_TrustDate_BEN',$pos)]" />
													</EstabDate>
												</xsl:if>
												<xsl:if
													test="string-length(../*[name()=concat('A_EntityName_BEN',$pos)])	>  0">
													<DBA>
														<xsl:value-of
															select="../*[name()=concat('A_EntityName_BEN',$pos)]" />
													</DBA>
												</xsl:if>
											</Organization>
											<xsl:if
												test="string-length(../*[name()=concat('A_AddressLine1_BEN',$pos)]) > 0 or
												string-length(../*[name()=concat('A_AddressLine2_BEN',$pos)]) > 0 or
												string-length(../*[name()=concat('A_AddressLine3_BEN',$pos)]) > 0 or
												string-length(../*[name()=concat('A_AddressLine4_BEN',$pos)]) > 0 or
												 string-length(../*[name()=concat('A_City_BEN',$pos)]) > 0 or 
												 (../*[name()=concat('A_State_BEN',$pos)] != '-1' and string-length(../*[name()=concat('A_State_BEN',$pos,'_Desc')]) > 0 ) or 
												 string-length(../*[name()=concat('A_ZipCode_BEN',$pos)]) > 0 or
												 (../*[name()=concat('A_Country_BEN',$pos)] != '-1' and string-length(../*[name()=concat('A_Country_BEN',$pos,'_Desc')]) > 0 )">
												<Address>
													<xsl:attribute name="id">
													<xsl:value-of
														select="concat('Address_BEN',$pos)" />
												</xsl:attribute>
													<xsl:if
														test="(../*[name()=concat('A_BeneficiaryType_BEN',$pos)]) = '1' ">
														<AddressTypeCode tc="1">Home</AddressTypeCode>
													</xsl:if>
													<xsl:if
														test="(../*[name()=concat('A_BeneficiaryType_BEN',$pos)]) = '2' ">
														<AddressTypeCode tc="2">Business
														</AddressTypeCode>
													</xsl:if>
													<Line1>
														<xsl:value-of
															select="../*[name()=concat('A_AddressLine1_BEN',$pos)]" />
													</Line1>
													<Line2>
														<xsl:value-of
															select="../*[name()=concat('A_AddressLine2_BEN',$pos)]" />
													</Line2>
													<Line3>
														<xsl:value-of
															select="../*[name()=concat('A_AddressLine3_BEN',$pos)]" />
													</Line3>
													<Line4>
														<xsl:value-of
															select="../*[name()=concat('A_AddressLine4_BEN',$pos)]" />
													</Line4>
													<xsl:if
														test="string-length(../*[name()=concat('A_City_BEN',$pos)]) > 0">
														<City>
															<xsl:value-of
																select="../*[name()=concat('A_City_BEN',$pos)]" />
														</City>
													</xsl:if>
													<xsl:if
														test="(../*[name()=concat('A_State_BEN',$pos)]) != '-1'">
														<AddressStateTC>
															<xsl:attribute name="tc">
															<xsl:value-of
																select="../*[name()=concat('A_State_BEN',$pos)]" />
														</xsl:attribute>
															<xsl:value-of
																select="../*[name()=concat('A_State_BEN',$pos, '_Desc')]" />
														</AddressStateTC>
													</xsl:if>
													<xsl:choose>
														<xsl:when
															test="contains(../*[name()=concat('A_ZipCode_BEN',$pos)] ,'-')">
															<Zip>
																<xsl:value-of
																	select="translate(../*[name()=concat('A_ZipCode_BEN',$pos)],'-','')" />
															</Zip>
														</xsl:when>
														<xsl:when
															test="not(contains(../*[name()=concat('A_ZipCode_BEN',$pos)] ,'-'))">
															<Zip>
																<xsl:value-of
																	select="../*[name()=concat('A_ZipCode_BEN',$pos)]" />
															</Zip>
														</xsl:when>
													</xsl:choose>
													<xsl:if
														test="(../*[name()=concat('A_Country_BEN',$pos)]) != '-1'">
														<AddressCountryTC>
															<xsl:attribute name="tc">
															<xsl:value-of
																select="../*[name()=concat('A_Country_BEN',$pos)]" />
														</xsl:attribute>
															<xsl:value-of
																select="../*[name()=concat('A_Country_BEN',$pos, '_Desc')]" />
														</AddressCountryTC>
													</xsl:if>
												</Address>
											</xsl:if>
											<xsl:if
												test="string-length(../*[name()=concat('A_PhoneNum_BEN',$pos)])>0">
												<Phone>
													<xsl:attribute name="id">
															<xsl:value-of
														select="concat('Phone_BEN_',$pos)" />
														</xsl:attribute>
													<xsl:if
														test="(../*[name()=concat('A_BeneficiaryType_BEN',$pos)]) = '1' ">
														<PhoneTypeCode tc="1">Home</PhoneTypeCode>
													</xsl:if>
													<xsl:if
														test="(../*[name()=concat('A_BeneficiaryType_BEN',$pos)]) = '2' ">
														<PhoneTypeCode tc="2">Business</PhoneTypeCode>
													</xsl:if>
													<AreaCode>
														<xsl:value-of
															select="substring(../*[name()=concat('A_PhoneNum_BEN',$pos)],1,3)" />
													</AreaCode>
													<DialNumber>
														<xsl:value-of
															select="substring(../*[name()=concat('A_PhoneNum_BEN',$pos)],4)" />
													</DialNumber>
												</Phone>
											</xsl:if>
										</Party>
									</xsl:if>
								</xsl:if>
							</xsl:if>
						</xsl:if>
					</xsl:for-each>
					<!-- BEN Party END -->
					<!-- CBN Party START -->
					<xsl:if test="./instanceData/TXLife/A_AddContingentBene='1'">
						<xsl:for-each select="instanceData/TXLife/*">
							<xsl:if test="starts-with(name(),'A_BeneficiaryType_CBN')">
								<xsl:if test="string-length(.) > 0">
									<xsl:variable name="pos"
										select="substring(name(),22)" />
									<xsl:variable name="benValue"
										select='format-number(../*[name()="A_COUNT_TOTAL_CBN"], "0")' />
									<xsl:variable name="posValue"
										select='format-number($pos, "0")' />
									<xsl:if test="$pos != '' and $posValue &lt;= $benValue">
										<xsl:if
											test="string-length(../*[name()=concat('A_FirstName_CBN',$pos)])> 0 or string-length(../*[name()=concat('A_LastName_CBN',$pos)])> 0 or string-length(../*[name()=concat('A_EntityName_CBN',$pos)])> 0 ">
											<Party>
												<xsl:attribute name="id">
													<xsl:value-of
													select="concat('Party_CBN',$pos)" />
												</xsl:attribute>
												<PartyTypeCode>
													<xsl:attribute name="tc">
														<xsl:value-of
														select="../*[name()=concat('A_BeneficiaryType_CBN',$pos)]" />
													</xsl:attribute>
													<xsl:value-of
														select="../*[name()=concat('A_BeneficiaryType_CBN',$pos, '_Desc')]" />
												</PartyTypeCode>
												<FullName>
													<xsl:value-of
														select="../*[name()=concat('A_EntityName_CBN',$pos)]" />
												</FullName>
												<xsl:if
													test="../*[name()=concat('A_BeneficiaryType_CBN',$pos)] = '1'">
													<xsl:if
														test="string-length(../*[name()=concat('A_GovtIDSSN_CBN',$pos)])	>  0">
														<GovtID>
															<xsl:value-of
																select="translate(../*[name()=concat('A_GovtIDSSN_CBN',$pos)],'-','')" />
														</GovtID>
														<GovtIDTC tc="1">Social Security Number</GovtIDTC>
													</xsl:if>
												</xsl:if>
												<xsl:if
													test="../*[name()=concat('A_BeneficiaryType_CBN',$pos)] = '2'">
													<xsl:if
														test="string-length(../*[name()=concat('A_GovtIDTID_CBN',$pos)])	>  0">
														<GovtID>
															<xsl:value-of
																select="translate(../*[name()=concat('A_GovtIDTID_CBN',$pos)],'-','')" />
														</GovtID>
														<GovtIDTC tc="2">Taxpayer Identification Number
														</GovtIDTC>
													</xsl:if>
												</xsl:if>
												<Person>
													<FirstName>
														<xsl:value-of
															select="../*[name()=concat('A_FirstName_CBN',$pos)]" />
													</FirstName>
													<MiddleName>
														<xsl:value-of
															select="../*[name()=concat('A_MiddleName_CBN',$pos)]" />
													</MiddleName>
													<LastName>
														<xsl:value-of
															select="../*[name()=concat('A_LastName_CBN',$pos)]" />
													</LastName>
													<xsl:if
														test="../*[name()=concat('A_Prefix_CBN',$pos)] != '-1'">
														<Prefix>
															<xsl:value-of
																select="../*[name()=concat('A_Prefix_CBN',$pos)]" />
														</Prefix>
													</xsl:if>
													<xsl:if
														test="../*[name()=concat('A_Suffix_CBN',$pos)] != '-1'">
														<Suffix>
															<xsl:value-of
																select="../*[name()=concat('A_Suffix_CBN',$pos)]" />
														</Suffix>
													</xsl:if>
													<xsl:if
														test="string-length(../*[name()=concat('A_DOB_CBN',$pos)])	>  0">
														<BirthDate>
															<xsl:value-of
																select="../*[name()=concat('A_DOB_CBN',$pos)]" />
														</BirthDate>
													</xsl:if>
												</Person>
												<Organization>
													<xsl:if
														test="string-length(../*[name()=concat('A_TrustDate_CBN',$pos)])	>  0">
														<EstabDate>
															<xsl:value-of
																select="../*[name()=concat('A_TrustDate_CBN',$pos)]" />
														</EstabDate>
													</xsl:if>
													<xsl:if
														test="string-length(../*[name()=concat('A_EntityName_CBN',$pos)])	>  0">
														<DBA>
															<xsl:value-of
																select="../*[name()=concat('A_EntityName_CBN',$pos)]" />
														</DBA>
													</xsl:if>
												</Organization>
												<xsl:if
													test="string-length(../*[name()=concat('A_AddressLine1_CBN',$pos)]) > 0 or
												string-length(../*[name()=concat('A_AddressLine2_CBN',$pos)]) > 0 or
												string-length(../*[name()=concat('A_AddressLine3_CBN',$pos)]) > 0 or
												string-length(../*[name()=concat('A_AddressLine4_CBN',$pos)]) > 0 or
												 string-length(../*[name()=concat('A_City_CBN',$pos)]) > 0 or 
												 (../*[name()=concat('A_State_CBN',$pos)] != '-1' and string-length(../*[name()=concat('A_State_CBN',$pos,'_Desc')]) > 0 ) or  
												 string-length(../*[name()=concat('A_ZipCode_CBN',$pos)]) > 0 or
												  (../*[name()=concat('A_Country_CBN',$pos)] != '-1' and string-length(../*[name()=concat('A_Country_CBN',$pos,'_Desc')]) > 0 )">
													<Address>
														<xsl:attribute name="id">
														<xsl:value-of
															select="concat('Address_CBN',$pos)" />
													</xsl:attribute>
														<xsl:if
															test="(../*[name()=concat('A_BeneficiaryType_CBN',$pos)]) = '1' ">
															<AddressTypeCode tc="1">Home
															</AddressTypeCode>
														</xsl:if>
														<xsl:if
															test="(../*[name()=concat('A_BeneficiaryType_CBN',$pos)]) = '2' ">
															<AddressTypeCode tc="2">Business
															</AddressTypeCode>
														</xsl:if>
														<xsl:if
															test="string-length(../*[name()=concat('A_AddressLine1_CBN',$pos)]) > 0">
															<Line1>
																<xsl:value-of
																	select="../*[name()=concat('A_AddressLine1_CBN',$pos)]" />
															</Line1>
														</xsl:if>
														<xsl:if
															test="string-length(../*[name()=concat('A_AddressLine2_CBN',$pos)]) > 0">
															<Line2>
																<xsl:value-of
																	select="../*[name()=concat('A_AddressLine2_CBN',$pos)]" />
															</Line2>
														</xsl:if>
														<xsl:if
															test="string-length(../*[name()=concat('A_AddressLine3_CBN',$pos)]) > 0">
															<Line3>
																<xsl:value-of
																	select="../*[name()=concat('A_AddressLine3_CBN',$pos)]" />
															</Line3>
														</xsl:if>
														<xsl:if
															test="string-length(../*[name()=concat('A_AddressLine4_CBN',$pos)]) > 0">
															<Line4>
																<xsl:value-of
																	select="../*[name()=concat('A_AddressLine4_CBN',$pos)]" />
															</Line4>
														</xsl:if>
														<xsl:if
															test="string-length(../*[name()=concat('A_City_CBN',$pos)]) > 0">
															<City>
																<xsl:value-of
																	select="../*[name()=concat('A_City_CBN',$pos)]" />
															</City>
														</xsl:if>
														<xsl:if
															test="(../*[name()=concat('A_State_CBN',$pos)]) != '-1'">
															<AddressStateTC>
																<xsl:attribute name="tc">
																<xsl:value-of
																	select="../*[name()=concat('A_State_CBN',$pos)]" />
															</xsl:attribute>
																<xsl:value-of
																	select="../*[name()=concat('A_State_CBN',$pos, '_Desc')]" />
															</AddressStateTC>
														</xsl:if>
														<xsl:choose>
															<xsl:when
																test="contains(../*[name()=concat('A_ZipCode_CBN',$pos)] ,'-')">
																<Zip>
																	<xsl:value-of
																		select="translate(../*[name()=concat('A_ZipCode_CBN',$pos)],'-','')" />
																</Zip>
															</xsl:when>
															<xsl:when
																test="not(contains(../*[name()=concat('A_ZipCode_CBN',$pos)] ,'-'))">
																<Zip>
																	<xsl:value-of
																		select="../*[name()=concat('A_ZipCode_CBN',$pos)]" />
																</Zip>
															</xsl:when>
														</xsl:choose>
														<xsl:if
															test="(../*[name()=concat('A_Country_CBN',$pos)]) != '-1'">
															<AddressCountryTC>
																<xsl:attribute name="tc">
																<xsl:value-of
																	select="../*[name()=concat('A_Country_CBN',$pos)]" />
															</xsl:attribute>
																<xsl:value-of
																	select="../*[name()=concat('A_Country_CBN',$pos, '_Desc')]" />
															</AddressCountryTC>
														</xsl:if>
													</Address>
												</xsl:if>
												<xsl:if
													test="string-length(../*[name()=concat('A_PhoneNum_CBN',$pos)])>0">
													<Phone>
														<xsl:attribute name="id">
															<xsl:value-of
															select="concat('Phone_CBN_',$pos)" />
														</xsl:attribute>
														<xsl:if
															test="(../*[name()=concat('A_BeneficiaryType_CBN',$pos)]) = '1' ">
															<PhoneTypeCode tc="1">Home</PhoneTypeCode>
														</xsl:if>
														<xsl:if
															test="(../*[name()=concat('A_BeneficiaryType_CBN',$pos)]) = '2' ">
															<PhoneTypeCode tc="2">Business</PhoneTypeCode>
														</xsl:if>
														<AreaCode>
															<xsl:value-of
																select="substring(../*[name()=concat('A_PhoneNum_CBN',$pos)],1,3)" />
														</AreaCode>
														<DialNumber>
															<xsl:value-of
																select="substring(../*[name()=concat('A_PhoneNum_CBN',$pos)],4)" />
														</DialNumber>
													</Phone>
												</xsl:if>
											</Party>
										</xsl:if>
									</xsl:if>
								</xsl:if>
							</xsl:if>
						</xsl:for-each>
					</xsl:if>
					<!-- CBN Party END -->
					<!-- Payor party -->
					<xsl:if
						test="./instanceData/TXLife/A_PremPayor ='5' and 
						(string-length(./instanceData/TXLife/A_EntityName_PYR))  >  0 or
						(string-length(./instanceData/TXLife/A_FirstName_PYR))  >  0 or
						(string-length(./instanceData/TXLife/A_LastName_PYR))  >  0">
						<Party id="Party_PYR">
							<xsl:if test="./instanceData/TXLife/A_AccHolder = '3'">
								<PartyTypeCode tc="2">Organization</PartyTypeCode>
								<FullName>
									<xsl:value-of
										select="instanceData/TXLife/A_EntityName_PYR" />
								</FullName>
								<xsl:if
									test="string-length(./instanceData/TXLife/A_GovtID_TID_PYR)  >  0">
									<GovtID>
										<xsl:value-of
											select="translate(./instanceData/TXLife/A_GovtID_TID_PYR,'-','')" />
									</GovtID>
									<GovtIDTC tc="2">Taxpayer Identification Number</GovtIDTC>
								</xsl:if>
								<Organization>
									<!-- <OrgForm> <xsl:attribute name="tc"> <xsl:value-of select="instanceData/TXLife/A_PayorType" 
										/> </xsl:attribute> <xsl:value-of select="instanceData/TXLife/A_PayorType_Desc" 
										/> </OrgForm> -->
									<DBA>
										<xsl:value-of
											select="instanceData/TXLife/A_EntityName_PYR" />
									</DBA>
								</Organization>
							</xsl:if>
							<xsl:if
								test="./instanceData/TXLife/A_AccHolder = '1' or ./instanceData/TXLife/A_AccHolder = '2'">
								<PartyTypeCode tc="1">Person</PartyTypeCode>
								<!-- BHFD-1172 -->
								<xsl:if
									test="string-length(./instanceData/TXLife/A_GovtID_TID_PYR)  >  0">
									<GovtID>
										<xsl:value-of
											select="translate(./instanceData/TXLife/A_GovtID_TID_PYR,'-','')" />
									</GovtID>
									<GovtIDTC tc="2">Taxpayer Identification Number</GovtIDTC>
								</xsl:if>
								<!-- <ResidenceCountry> <xsl:attribute name="tc"> <xsl:value-of select="instanceData/TXLife/A_ResidencyCountry_PYR" 
									/> </xsl:attribute> <xsl:value-of select="instanceData/TXLife/A_ResidencyCountry_PYR_Desc" 
									/> </ResidenceCountry> -->
								<Person>
									<FirstName>
										<xsl:value-of
											select="instanceData/TXLife/A_FirstName_PYR" />
									</FirstName>
									<xsl:if
										test="string-length(./instanceData/TXLife/A_MiddleName_PYR) > 0">
										<MiddleName>
											<xsl:value-of
												select="instanceData/TXLife/A_MiddleName_PYR" />
										</MiddleName>
									</xsl:if>
									<LastName>
										<xsl:value-of
											select="instanceData/TXLife/A_LastName_PYR" />
									</LastName>
									<xsl:if
										test="./instanceData/TXLife/A_Prefix_PYR != '-1'">
										<Prefix>
											<xsl:value-of
												select="instanceData/TXLife/A_Prefix_PYR" />
										</Prefix>
									</xsl:if>
									<xsl:if
										test="./instanceData/TXLife/A_Suffix_PYR != '-1'">
										<Suffix>
											<xsl:value-of
												select="instanceData/TXLife/A_Suffix_PYR" />
										</Suffix>
									</xsl:if>
									<!-- <BirthDate> <xsl:call-template name="FormatDate"> <xsl:with-param 
										name="Separator"> / </xsl:with-param> <xsl:with-param name="DateString"> 
										<xsl:value-of select="instanceData/TXLife/A_DOB_PYR" /> </xsl:with-param> 
										</xsl:call-template> </BirthDate> -->
								</Person>
							</xsl:if>
							<Address id="Address_PYR">
								<xsl:if
									test="./instanceData/TXLife/A_AccHolder = '1' or ./instanceData/TXLife/A_AccHolder = '2'">
									<AddressTypeCode tc="1">Home</AddressTypeCode>
								</xsl:if>
								<xsl:if test="./instanceData/TXLife/A_AccHolder = '3'">
									<AddressTypeCode tc="2">Business</AddressTypeCode>
								</xsl:if>
								<Line1>
									<xsl:value-of
										select="instanceData/TXLife/A_AddressLine1_PYR" />
								</Line1>
								<Line2>
									<xsl:value-of
										select="instanceData/TXLife/A_AddressLine2_PYR" />
								</Line2>
								<Line3>
									<xsl:value-of
										select="instanceData/TXLife/A_AddressLine3_PYR" />
								</Line3>
								<Line4>
									<xsl:value-of
										select="instanceData/TXLife/A_AddressLine4_PYR" />
								</Line4>
								<City>
									<xsl:value-of
										select="instanceData/TXLife/A_City_PYR" />
								</City>
								<AddressStateTC>
									<xsl:attribute name="tc">
											<xsl:value-of
										select="instanceData/TXLife/A_State_PYR" />
										</xsl:attribute>
									<xsl:value-of
										select="instanceData/TXLife/A_State_PYR_Desc" />
								</AddressStateTC>
								<xsl:choose>
									<xsl:when
										test="contains(instanceData/TXLife/A_ZipCode_PYR ,'-')">
										<Zip>
											<xsl:value-of
												select="translate(instanceData/TXLife/A_ZipCode_PYR,'-','')" />
										</Zip>
									</xsl:when>
									<xsl:when
										test="not(contains(instanceData/TXLife/A_ZipCode_PYR ,'-'))">
										<Zip>
											<xsl:value-of
												select="instanceData/TXLife/A_ZipCode_PYR" />
										</Zip>
									</xsl:when>
								</xsl:choose>
								<AddressCountryTC>
									<xsl:attribute name="tc">
											<xsl:value-of
										select="instanceData/TXLife/A_Country_PYR" />
										</xsl:attribute>
									<xsl:value-of
										select="instanceData/TXLife/A_Country_PYR_Desc" />
								</AddressCountryTC>
							</Address>
							<!-- <xsl:if test="string-length(./instanceData/TXLife/A_PhoneNum_PYR) 
								> 0"> <Phone id="Phone1_PYR"> <xsl:if test="(./instanceData/TXLife/A_PayorType) 
								= '100'"> <PhoneTypeCode tc="1">Home</PhoneTypeCode> </xsl:if> <xsl:if test="(./instanceData/TXLife/A_PayorType) 
								!= '100'"> <PhoneTypeCode tc="2">Business</PhoneTypeCode> </xsl:if> <AreaCode> 
								<xsl:value-of select="substring(./instanceData/TXLife/A_PhoneNum_PYR,1,3)" 
								/> </AreaCode> <DialNumber> <xsl:value-of select="substring(./instanceData/TXLife/A_PhoneNum_PYR,4)" 
								/> </DialNumber> </Phone> </xsl:if> -->
						</Party>
					</xsl:if>
					<!-- Producer AGT Party -->
					<xsl:for-each select="instanceData/TXLife/*">
						<xsl:if test="starts-with(name(),'A_AgentID_AGT')">
							<xsl:if test="string-length(.) > 0">
								<xsl:variable name="pos"
									select="substring(name(),14)" />
								<xsl:variable name="agentValue"
									select='format-number(../*[name()="A_COUNT_TOTAL_AGT"], "0")' />
								<xsl:variable name="posValue"
									select='format-number($pos, "0")' />
								<xsl:if test="$pos != '' and $posValue &lt;= $agentValue">
									<xsl:if
										test="string-length(../*[name()=concat('A_FirstName_AGT',$pos)])>0 or 
											string-length(../*[name()=concat('A_LastName_AGT',$pos)])>0">
										<Party>
											<xsl:attribute name="id">
												<xsl:value-of
												select="concat('Party_AGT',$pos)" />
											</xsl:attribute>
											<PartyTypeCode tc="1">Person</PartyTypeCode>
											<Person>
												<FirstName>
													<xsl:value-of
														select="../*[name()=concat('A_FirstName_AGT',$pos)]" />
												</FirstName>
												<xsl:if
													test="string-length(../*[name()=concat('A_MiddleName_AGT',$pos)])	> 0">
													<MiddleName>
														<xsl:value-of
															select="../*[name()=concat('A_MiddleName_AGT',$pos)]" />
													</MiddleName>
												</xsl:if>
												<LastName>
													<xsl:value-of
														select="../*[name()=concat('A_LastName_AGT',$pos)]" />
												</LastName>
												<xsl:if
													test="../*[name()=concat('A_Prefix_AGT',$pos)] != '-1'">
													<Prefix>
														<xsl:value-of
															select="../*[name()=concat('A_Prefix_AGT',$pos)]" />
													</Prefix>
												</xsl:if>
												<xsl:if
													test="../*[name()=concat('A_Suffix_AGT',$pos)] != '-1'">
													<Suffix>
														<xsl:value-of
															select="../*[name()=concat('A_Suffix_AGT',$pos)]" />
													</Suffix>
												</xsl:if>
											</Person>
											<xsl:if
												test="string-length(../*[name()=concat('A_Phone_AGT',$pos)])>0">
												<Phone>
													<xsl:attribute name="id">
														<xsl:value-of
														select="concat('Phone_AGT',$pos)" />
													</xsl:attribute>
													<PhoneTypeCode tc="2">Business</PhoneTypeCode>
													<AreaCode>
														<xsl:value-of
															select="substring(../*[name()=concat('A_Phone_AGT',$pos)],1,3)" />
													</AreaCode>
													<DialNumber>
														<xsl:value-of
															select="substring(../*[name()=concat('A_Phone_AGT',$pos)],4)" />
													</DialNumber>
												</Phone>
											</xsl:if>
											<Producer>
												<xsl:if
													test=" string-length(../*[name()=concat('A_LicenseNoFL_AGT',$pos)]) > 	0">
													<License>
														<xsl:attribute name="id">
															<xsl:value-of
															select="concat('License_AGT',$pos)" />
														</xsl:attribute>
														<LicenseID>
															<xsl:value-of
																select="../*[name()=concat('A_LicenseNoFL_AGT',$pos)]" />
														</LicenseID>
														<LicenseState>
															<xsl:attribute name="tc">
															<xsl:value-of
																select="../A_ApplicationJurisdiction" />
														</xsl:attribute>
															<xsl:value-of
																select="../A_ApplicationJurisdiction_Desc" />
														</LicenseState>
													</License>
												</xsl:if>
												<CarrierAppointment>
													<CompanyProducerID>
														<xsl:value-of
															select="../*[name()=concat('A_AgentID_AGT',$pos)]" />
													</CompanyProducerID>
												</CarrierAppointment>
											</Producer>
										</Party>
									</xsl:if>
								</xsl:if>
							</xsl:if>
						</xsl:if>
					</xsl:for-each>
					<!-- Producer AGT Party END -->
					<!-- Relation object to associate the carrier party and the holding 
						for the Deseased Owner policy. -->
					<xsl:if
						test="(./instanceData/TXLife/A_ContractAppliedFor ='100990001' or ./instanceData/TXLife/A_ContractAppliedFor='100990002') and
											string-length(./instanceData/TXLife/A_CurrentCompany_DecedentIRA_Desc) > 0">
						<Relation id="Relation_Decedent_Holding"
							OriginatingObjectID="Holding_DeceasedOwner"
							RelatedObjectID="Party_Decedent_CAR">
							<OriginatingObjectType tc="4">Holding
							</OriginatingObjectType>
							<RelatedObjectType tc="6">Party</RelatedObjectType>
							<RelationRoleCode tc="88">Holding Company
							</RelationRoleCode>
						</Relation>
					</xsl:if>
					<!-- Relation object to identify Deseased policy Holding is replaced 
						by Holding_1 -->
					<xsl:if
						test="(./instanceData/TXLife/A_ContractAppliedFor ='100990001' or ./instanceData/TXLife/A_ContractAppliedFor='100990002') and
											string-length(./instanceData/TXLife/A_CurrentCompany_DecedentIRA_Desc) > 0">
						<Relation id="Relation_RPL_Decedent"
							OriginatingObjectID="Holding_1"
							RelatedObjectID="Holding_DeceasedOwner">
							<OriginatingObjectType tc="4">Holding
							</OriginatingObjectType>
							<RelatedObjectType tc="4">Holding
							</RelatedObjectType>
							<RelationRoleCode tc="64">Replaced by
							</RelationRoleCode>
						</Relation>
					</xsl:if>
					<!-- Create a Party/Party relation between the Decedent and Annuitant -->
					<xsl:if
						test="(./instanceData/TXLife/A_ContractAppliedFor ='100990001' or ./instanceData/TXLife/A_ContractAppliedFor='100990002') and
											(string-length(./instanceData/TXLife/A_FirstName_DecedentIRA) > 0 or
											string-length(./instanceData/TXLife/A_LastName_DecedentIRA) > 0 ) ">
						<Relation id="Relation_Decedent"
							OriginatingObjectID="Holding_1"
							RelatedObjectID="Party_DeceasedOwner">
							<OriginatingObjectType tc="4">Holding
							</OriginatingObjectType>
							<RelatedObjectType tc="6">Party</RelatedObjectType>
							<RelationRoleCode tc="1009900DCS">Deceased Original Owner
							</RelationRoleCode><!-- Citation needed for actual tc value -->
							<xsl:if
								test="(./instanceData/TXLife/A_IsSpousal_DecedentIRA = '1'">
								<RelationDescription tc="900">Spouse
								</RelationDescription>
							</xsl:if>
							<xsl:if
								test="(./instanceData/TXLife/A_IsSpousal_DecedentIRA = '2'">
								<RelationDescription tc="2147483647">Other
								</RelationDescription>
							</xsl:if>
						</Relation>
					</xsl:if>
					<!-- Replacement relation holding/holding -->
					<xsl:for-each select="instanceData/TXLife/*">
						<xsl:if test="starts-with(name(),'A_PolNum_REP')">
							<xsl:variable name="pos"
								select="substring(name(),13)" />
							<xsl:variable name="repCount"
								select='format-number(../*[name()="A_COUNT_TOTAL_REP"], "0")' />
							<xsl:variable name="posValue"
								select='format-number($pos, "0")' />
							<xsl:if test="$pos != '' and $posValue &lt;= $repCount">
								<xsl:if
									test=" ../A_ChangeExistingPolicyInd_PINS='1' and
											../*[name()=concat('A_ReplacementCompany_REP',$pos)]!='-1'">
									<Relation OriginatingObjectID="Holding_1">
										<xsl:attribute name="RelatedObjectID">
															<xsl:value-of
											select="concat('Holding_REP_',$pos)" />
														</xsl:attribute>
										<xsl:attribute name="id">
															<xsl:value-of
											select="concat('Relation_REP',$pos,'_2')" />
														</xsl:attribute>
										<OriginatingObjectType tc="4">Holding
										</OriginatingObjectType>
										<RelatedObjectType tc="4">Holding
										</RelatedObjectType>
										<RelationRoleCode tc="64">Replaced by
										</RelationRoleCode>
										<!-- <xsl:if test="../*[name()=concat('A_ReplacementInd_REP',$pos)]='0'"> 
											<RelationRoleCode tc="124">Existing Insurance </RelationRoleCode> </xsl:if> -->
									</Relation>
								</xsl:if>
							</xsl:if>
						</xsl:if>
					</xsl:for-each>
					<!-- Carrier party and the holding for the existing relation -->
					<xsl:for-each select="instanceData/TXLife/*">
						<xsl:if test="starts-with(name(),'A_PolNum_REP')">
							<xsl:if test="string-length(.) > 0">
								<xsl:variable name="pos"
									select="substring(name(),13)" />
								<xsl:variable name="repCount"
									select='format-number(../*[name()="A_COUNT_TOTAL_REP"], "0")' />
								<xsl:variable name="posValue"
									select='format-number($pos, "0")' />
								<xsl:if test="$pos != '' and $posValue &lt;= $repCount">
									<Relation>
										<xsl:attribute name="RelatedObjectID">
														<xsl:value-of
											select="concat('Holding_REP_',$pos')" />
													</xsl:attribute>
										<xsl:attribute name="OriginatingObjectID">
														<xsl:value-of
											select="concat('Party_REP',$pos,'_CAR')" />
													</xsl:attribute>
										<xsl:attribute name="id">
														<xsl:value-of
											select="concat('Relation_REP',$pos,'_1')" />
													</xsl:attribute>
										<OriginatingObjectType tc="6">Party
										</OriginatingObjectType>
										<RelatedObjectType tc="4">Holding
										</RelatedObjectType>
										<RelationRoleCode tc="88">Holding Company
										</RelationRoleCode>
									</Relation>
								</xsl:if>
							</xsl:if>
						</xsl:if>
					</xsl:for-each>
					<!-- <xsl:for-each select="instanceData/TXLife/*"> <xsl:if test="starts-with(name(),'A_InsuranceAmount_REP')"> 
						<xsl:if test="string-length(.) > 0"> <xsl:variable name="pos" select="substring(name(),22)" 
						/> <xsl:variable name="repCount" select='format-number(../*[name()="A_COUNT_TOTAL_REP"], 
						"0")' /> <xsl:variable name="posValue" select='format-number($pos, "0")' 
						/> <xsl:if test="$pos != '' and $posValue &lt;= $repCount"> <xsl:if test="string-length(../*[name()=concat('A_LastName_REP',$pos)])>0"> 
						<Relation> <xsl:attribute name="RelatedObjectID"> <xsl:value-of select="concat('Party_REP',$pos,'_INS')" 
						/> </xsl:attribute> <xsl:attribute name="OriginatingObjectID"> <xsl:value-of 
						select="concat('Holding_REP_',$pos)" /> </xsl:attribute> <xsl:attribute name="id"> 
						<xsl:value-of select="concat('Relation_REP',$pos,'_3')" /> </xsl:attribute> 
						<OriginatingObjectType tc="4">Holding </OriginatingObjectType> <RelatedObjectType 
						tc="6">Party </RelatedObjectType> <RelationRoleCode tc="32">Insured </RelationRoleCode> 
						<RelationDescription tc="91">Self </RelationDescription> </Relation> </xsl:if> 
						</xsl:if> </xsl:if> </xsl:if> </xsl:for-each> -->
					<!-- Annuitant Relation -->
					<Relation id="Relation_PINS"
						OriginatingObjectID="Holding_1" RelatedObjectID="Party_PINS">
						<OriginatingObjectType tc="4">Holding
						</OriginatingObjectType>
						<RelatedObjectType tc="6">Party</RelatedObjectType>
						<RelationRoleCode tc="35">Annuitant</RelationRoleCode>
						<xsl:if
							test="./instanceData/TXLife/A_ProductCode_Annuity = 'DP5LNO' and ./instanceData/TXLife/A_OwnOtherThanAnn != '1'">
							<RelationDescription tc="91">Self
							</RelationDescription>
						</xsl:if>
						<xsl:if
							test="./instanceData/TXLife/A_ProductCode_Annuity = 'DP5LNO' and ./instanceData/TXLife/A_OwnOtherThanAnn = '1'">
							<RelationDescription tc="2147483647">Other
							</RelationDescription>
						</xsl:if>
					</Relation>
					<!-- Joint Annuitant Relation -->
					<xsl:if
						test="./instanceData/TXLife/A_JointAnnInd = '1' and
							(string-length(./instanceData/TXLife/A_FirstName_JNT) > 0 or 
											string-length(./instanceData/TXLife/A_LastName_JNT) > 0 )">
						<Relation id="Relation_PINS"
							OriginatingObjectID="Holding_1" RelatedObjectID="Party_JNT">
							<OriginatingObjectType tc="4">Holding
							</OriginatingObjectType>
							<RelatedObjectType tc="6">Party</RelatedObjectType>
							<RelationRoleCode tc="183">Joint Annuitant
							</RelationRoleCode>
							<RelationDescription>
								<xsl:attribute name="tc">
										<xsl:value-of
									select="instanceData/TXLife/A_RelToAnn_JNT" />
									</xsl:attribute>
								<xsl:value-of
									select="instanceData/TXLife/A_RelToAnn_JNT_Desc" />
							</RelationDescription>
						</Relation>
					</xsl:if>
					<!-- Owner Relation when Annuitant is Owner -->
					<xsl:if test="./instanceData/TXLife/A_OwnOtherThanAnn = '0'">
						<Relation id="Relation_OWN1"
							OriginatingObjectID="Holding_1" RelatedObjectID="Party_PINS">
							<OriginatingObjectType tc="4">Holding
							</OriginatingObjectType>
							<RelatedObjectType tc="6">Party</RelatedObjectType>
							<RelationRoleCode tc="8">Owner</RelationRoleCode>
							<RelationDescription tc="91">Self
							</RelationDescription>
						</Relation>
					</xsl:if>
					<!-- Joint OWN Relation when Joint Annuitant = Joint OWN -->
					<xsl:if
						test="./instanceData/TXLife/A_JointOwnInd != '1' and ./instanceData/TXLife/A_JointAnnInd = '1'">
						<xsl:if
							test="string-length(./instanceData/TXLife/A_FirstName_JNT) > 0 or 
											string-length(./instanceData/TXLife/A_LastName_JNT) > 0 ">
							<Relation id="Relation_OWN2"
								OriginatingObjectID="Holding_1" RelatedObjectID="Party_JNT">
								<OriginatingObjectType tc="4">Holding
								</OriginatingObjectType>
								<RelatedObjectType tc="6">Party
								</RelatedObjectType>
								<RelationRoleCode tc="184">Joint Owner
								</RelationRoleCode>
								<RelationDescription>
									<xsl:attribute name="tc">
										<xsl:value-of
										select="instanceData/TXLife/A_RelToAnn_JNT" />
									</xsl:attribute>
									<xsl:value-of
										select="instanceData/TXLife/A_RelToAnn_JNT_Desc" />
								</RelationDescription>
							</Relation>
						</xsl:if>
					</xsl:if>
					<!-- OWN Relation -->
					<xsl:if test="./instanceData/TXLife/A_OwnOtherThanAnn = '1'">
						<xsl:if
							test="string-length(./instanceData/TXLife/A_EntityName_OWN) > 0 or 
											string-length(./instanceData/TXLife/A_FirstName_OWN) > 0 or 
											string-length(./instanceData/TXLife/A_LastName_OWN) > 0 ">
							<Relation id="Relation_OWN1"
								OriginatingObjectID="Holding_1">
								<xsl:if test="./instanceData/TXLife/A_OwnerType = '1'">
									<xsl:attribute name="RelatedObjectID">Party_OWN</xsl:attribute>
								</xsl:if>
								<xsl:if test="./instanceData/TXLife/A_OwnerType = '2'">
									<xsl:attribute name="RelatedObjectID">Party_ENTITY</xsl:attribute>
								</xsl:if>
								<OriginatingObjectType tc="4">Holding
								</OriginatingObjectType>
								<RelatedObjectType tc="6">Party
								</RelatedObjectType>
								<RelationRoleCode tc="8">Owner</RelationRoleCode>
								<RelationDescription tc="91">Self
								</RelationDescription>
							</Relation>
						</xsl:if>
					</xsl:if>
					<!-- Joint OWN Relation -->
					<xsl:if test="./instanceData/TXLife/A_JointOwnInd = '1'">
						<xsl:if
							test="string-length(./instanceData/TXLife/A_FirstName_JointOwn) > 0 or 
											string-length(./instanceData/TXLife/A_LastName_JointOwn) > 0 ">
							<Relation id="Relation_OWN2"
								OriginatingObjectID="Holding_1" RelatedObjectID="Party_JointOwn">
								<OriginatingObjectType tc="4">Holding
								</OriginatingObjectType>
								<RelatedObjectType tc="6">Party
								</RelatedObjectType>
								<RelationRoleCode tc="184">Joint Owner
								</RelationRoleCode>
								<RelationDescription>
									<xsl:attribute name="tc">
										<xsl:value-of
										select="instanceData/TXLife/A_RelToOwner_JointOwn" />
									</xsl:attribute>
									<xsl:value-of
										select="instanceData/TXLife/A_RelToOwner_JointOwn_Desc" />
								</RelationDescription>
							</Relation>
						</xsl:if>
					</xsl:if>
					<!-- Authorized Person Relation for Enitity Owner -->
					<xsl:if
						test="string-length(./instanceData/TXLife/A_FirstName_AUTHORIZED)>0 or string-length(./instanceData/TXLife/A_LastName_AUTHORIZED)>0">
						<Relation id="Relation_AUTHORIZED"
							OriginatingObjectID="Party_ENTITY"
							RelatedObjectID="Party_AUTHORIZED">
							<OriginatingObjectType tc="6">Party
							</OriginatingObjectType>
							<RelatedObjectType tc="6">Party</RelatedObjectType>
							<xsl:if test="./instanceData/TXLife/A_OwnerType_OWN='2'">
								<RelationRoleCode tc="146">Business Partner
								</RelationRoleCode>
							</xsl:if>
							<xsl:if
								test="./instanceData/TXLife/A_OwnerType_OWN='1' or
													./instanceData/TXLife/A_OwnerType_OWN='23' or 
													./instanceData/TXLife/A_OwnerType_OWN='11' or 
													 ./instanceData/TXLife/A_OwnerType_OWN='2147483647'  ">
								<RelationRoleCode tc="1009900003">Company Officer
								</RelationRoleCode><!--Pending tc value for Custodian Owner -->
							</xsl:if>
							<xsl:if test="./instanceData/TXLife/A_OwnerType_OWN ='16'">
								<RelationRoleCode tc="69">Trustee</RelationRoleCode>
							</xsl:if>
						</Relation>
					</xsl:if>
					<!-- BEN Relation -->
					<xsl:for-each select="instanceData/TXLife/*">
						<xsl:if test="starts-with(name(),'A_BeneficiaryType_BEN')">
							<xsl:if test="string-length(.) > 0">
								<xsl:variable name="pos"
									select="substring(name(),22)" />
								<xsl:variable name="benValue"
									select='format-number(../*[name()="A_COUNT_TOTAL_BEN"], "0")' />
								<xsl:variable name="posValue"
									select='format-number($pos, "0")' />
								<xsl:if test="$pos != '' and $posValue &lt;= $benValue">
									<xsl:if
										test="string-length(../*[name()=concat('A_FirstName_BEN',$pos)])> 0 or 
										string-length(../*[name()=concat('A_LastName_BEN',$pos)])> 0 or 
										string-length(../*[name()=concat('A_EntityName_BEN',$pos)])> 0 or
										../*[name()=concat('A_BeneficiarySameAs_BEN',$pos)] !='-1'">
										<Relation OriginatingObjectID="Holding_1">
											<xsl:choose>
												<xsl:when
													test="../*[name()=concat('A_BeneficiarySameAs_BEN',$pos)] = '1'">
													<xsl:attribute name="RelatedObjectID">Party_PINS</xsl:attribute>
												</xsl:when>
												<xsl:when
													test="../*[name()=concat('A_BeneficiarySameAs_BEN',$pos)] = '2'">
													<xsl:attribute name="RelatedObjectID">Party_JNT</xsl:attribute>
												</xsl:when>
												<xsl:when
													test="../*[name()=concat('A_BeneficiarySameAs_BEN',$pos)] = '3' and ../A_OwnerType = '1'">
													<xsl:attribute name="RelatedObjectID">Party_OWN</xsl:attribute>
												</xsl:when>
												<xsl:when
													test="../*[name()=concat('A_BeneficiarySameAs_BEN',$pos)] = '3' and ../A_OwnerType = '2'">
													<xsl:attribute name="RelatedObjectID">Party_ENTITY</xsl:attribute>
												</xsl:when>
												<xsl:when
													test="../*[name()=concat('A_BeneficiarySameAs_BEN',$pos)] = '4'">
													<xsl:attribute name="RelatedObjectID">Party_JointOwn</xsl:attribute>
												</xsl:when>
												<xsl:when
													test="../*[name()=concat('A_BeneficiarySameAs_BEN',$pos)] = '-1'">
													<xsl:attribute name="RelatedObjectID">
													<xsl:value-of
														select="concat('Party_BEN',$pos)" />
													</xsl:attribute>
												</xsl:when>
											</xsl:choose>
											<xsl:attribute name="id">
														<xsl:value-of
												select="concat('Relation_BEN',$pos)" />
													</xsl:attribute>
											<OriginatingObjectType tc="4">Holding
											</OriginatingObjectType>
											<RelatedObjectType tc="6">Party
											</RelatedObjectType>
											<RelationRoleCode tc="34">Beneficiary
											</RelationRoleCode>
											<xsl:choose>
												<xsl:when
													test="../*[name()=concat('A_RelToOwner_BEN',$pos)] = '1000500013'">
													<RelationDescription tc="1000500022">Relative
													</RelationDescription>
												</xsl:when>
												<xsl:when
													test="../*[name()=concat('A_RelToOwner_BEN',$pos)] = '1009900002'">
													<RelationDescription tc="1009900005">Insureds
														Company
													</RelationDescription>
												</xsl:when>
												<xsl:when
													test="../*[name()=concat('A_RelToOwner_BEN',$pos)] 
													= '1009900003'">
													<RelationDescription tc="1009900007">Irrevocable
														Trustee
													</RelationDescription>
												</xsl:when>
												<xsl:when
													test="../*[name()=concat('A_RelToOwner_BEN',$pos)] 
													= '1000500005'">
													<RelationDescription tc="1000500014">Business
														Associate
													</RelationDescription>
												</xsl:when>
												<xsl:when
													test="../*[name()=concat('A_RelToOwner_BEN',$pos)] 
													= '1000500006'">
													<RelationDescription tc="1000500014">Business
														Associate
													</RelationDescription>
												</xsl:when>
												<xsl:when
													test="../*[name()=concat('A_RelToOwner_BEN',$pos)] 
													= '1000500007'">
													<RelationDescription tc="1000500016">Charity
													</RelationDescription>
												</xsl:when>
												<xsl:when
													test="../*[name()=concat('A_RelToOwner_BEN',$pos)] 
													= '1000500008'">
													<RelationDescription tc="1000500018">Employer
													</RelationDescription>
												</xsl:when>
												<xsl:when
													test="../*[name()=concat('A_RelToOwner_BEN',$pos)] 
													= '1000500009'">
													<RelationDescription tc="1000500015">Partner
													</RelationDescription>
												</xsl:when>
												<xsl:when
													test="../*[name()=concat('A_RelToOwner_BEN',$pos)] 
													= '1000500010'">
													<RelationDescription tc="1009900006">Grandchild
													</RelationDescription>
												</xsl:when>
												<xsl:when
													test="../*[name()=concat('A_RelToOwner_BEN',$pos)] 
													= '1009900001'">
													<RelationDescription tc="1009900004">Friend
													</RelationDescription>
												</xsl:when>
												<xsl:when
													test="../*[name()=concat('A_RelToOwner_BEN',$pos)] 
													= '1000500012'">
													<RelationDescription tc="1000500013">No Relation
													</RelationDescription>
												</xsl:when>
												<xsl:when
													test="../*[name()=concat('A_RelToOwner_BEN',$pos)] 
													= '9999'">
													<RelationDescription tc="1000500023">Unknown
													</RelationDescription>
												</xsl:when>
												<xsl:when
													test="../*[name()=concat('A_RelToOwner_BEN',$pos)] 
													= '1000500014'">
													<RelationDescription tc="1000500012">Children
													</RelationDescription>
												</xsl:when>
												<xsl:when
													test="../*[name()=concat('A_RelToOwner_BEN',$pos)] = '13'">
													<RelationDescription tc="1000500012">Children
													</RelationDescription>
												</xsl:when>
												<xsl:when
													test="../*[name()=concat('A_RelToOwner_BEN',$pos)] 
													= '2'">
													<RelationDescription tc="1000500011">Estate of
														Insured
													</RelationDescription>
												</xsl:when>
												<xsl:when
													test="../*[name()=concat('A_RelToOwner_BEN',$pos)] = '20'">
													<RelationDescription tc="1000500006">Parents
													</RelationDescription>
												</xsl:when>
												<xsl:when
													test="../*[name()=concat('A_RelToOwner_BEN',$pos)] = '4'">
													<RelationDescription tc="1000500017">Creditors
													</RelationDescription>
												</xsl:when>
												<xsl:when
													test="../*[name()=concat('A_RelToOwner_BEN',$pos)] 
													= '51'">
													<RelationDescription tc="1000500004">Corporation
													</RelationDescription>
												</xsl:when>
												<xsl:when
													test="../*[name()=concat('A_RelToOwner_BEN',$pos)] = '7'">
													<RelationDescription tc="1000500019">Trust
													</RelationDescription>
												</xsl:when>
												<xsl:when
													test="../*[name()=concat('A_RelToOwner_BEN',$pos)] 
													= '9'">
													<RelationDescription tc="900">Spouse
													</RelationDescription>
												</xsl:when>
												<xsl:when
													test="../*[name()=concat('A_RelToOwner_BEN',$pos)] 
													= '1000500011'">
													<RelationDescription tc="1000500009">Grandparent
													</RelationDescription>
												</xsl:when>
											</xsl:choose>
											<InterestPercent>
												<xsl:value-of
													select="../*[name()=concat('A_InterestPercent_BEN',$pos)]" />
											</InterestPercent>
											<BeneficiaryDesignation>
												<xsl:attribute name="tc">
															<xsl:value-of
													select="../*[name()=concat('A_RelToOwner_BEN',$pos)]" />
														</xsl:attribute>
												<xsl:value-of
													select="../*[name()=concat('A_RelToOwner_BEN',$pos, '_Desc')]" />
											</BeneficiaryDesignation>
											<OLifEExtension
												ExtensionCode="Relation 2.8.90" VendorCode="05">
												<RelationExtension>
													<BeneficiaryDistributionOption
														tc="2">Percentage</BeneficiaryDistributionOption>
												</RelationExtension>
											</OLifEExtension>
										</Relation>
									</xsl:if>
								</xsl:if>
							</xsl:if>
						</xsl:if>
					</xsl:for-each>
					<!-- Contigent beneficiary Relation -->
					<xsl:for-each select="instanceData/TXLife/*">
						<xsl:if test="starts-with(name(),'A_BeneficiaryType_CBN')">
							<xsl:if test="string-length(.) > 0">
								<xsl:variable name="pos"
									select="substring(name(),22)" />
								<xsl:variable name="benValue"
									select='format-number(../*[name()="A_COUNT_TOTAL_CBN"], "0")' />
								<xsl:variable name="posValue"
									select='format-number($pos, "0")' />
								<xsl:if test="$pos != '' and $posValue &lt;= $benValue">
									<xsl:if
										test="string-length(../*[name()=concat('A_FirstName_CBN',$pos)])> 0 or string-length(../*[name()=concat('A_LastName_CBN',$pos)])> 0 or string-length(../*[name()=concat('A_EntityName_CBN',$pos)])> 0 ">
										<Relation OriginatingObjectID="Holding_1">
											<xsl:attribute name="RelatedObjectID">
														<xsl:value-of
												select="concat('Party_CBN',$pos)" />
													</xsl:attribute>
											<xsl:attribute name="id">
														<xsl:value-of
												select="concat('Relation_CBN',$pos)" />
													</xsl:attribute>
											<!--BHFD-1400 -->
											<OriginatingObjectType tc="4">Holding
											</OriginatingObjectType>
											<RelatedObjectType tc="6">Party
											</RelatedObjectType>
											<RelationRoleCode tc="36">Contigent Beneficiary
											</RelationRoleCode>
											<xsl:choose>
												<xsl:when
													test="../*[name()=concat('A_RelToOwner_CBN',$pos)] = '1000500013'">
													<RelationDescription tc="1000500022">Relative
													</RelationDescription>
												</xsl:when>
												<xsl:when
													test="../*[name()=concat('A_RelToOwner_CBN',$pos)] = '1009900002'">
													<RelationDescription tc="1009900005">Insureds
														Company
													</RelationDescription>
												</xsl:when>
												<xsl:when
													test="../*[name()=concat('A_RelToOwner_CBN',$pos)] 
													= '1009900003'">
													<RelationDescription tc="1009900007">Irrevocable
														Trustee
													</RelationDescription>
												</xsl:when>
												<xsl:when
													test="../*[name()=concat('A_RelToOwner_CBN',$pos)] 
													= '1000500005'">
													<RelationDescription tc="1000500014">Business
														Associate
													</RelationDescription>
												</xsl:when>
												<xsl:when
													test="../*[name()=concat('A_RelToOwner_CBN',$pos)] 
													= '1000500006'">
													<RelationDescription tc="1000500014">Business
														Associate
													</RelationDescription>
												</xsl:when>
												<xsl:when
													test="../*[name()=concat('A_RelToOwner_CBN',$pos)] 
													= '1000500007'">
													<RelationDescription tc="1000500016">Charity
													</RelationDescription>
												</xsl:when>
												<xsl:when
													test="../*[name()=concat('A_RelToOwner_CBN',$pos)] 
													= '1000500008'">
													<RelationDescription tc="1000500018">Employer
													</RelationDescription>
												</xsl:when>
												<xsl:when
													test="../*[name()=concat('A_RelToOwner_CBN',$pos)] 
													= '1000500009'">
													<RelationDescription tc="1000500015">Partner
													</RelationDescription>
												</xsl:when>
												<xsl:when
													test="../*[name()=concat('A_RelToOwner_CBN',$pos)] 
													= '1000500010'">
													<RelationDescription tc="1009900006">Grandchild
													</RelationDescription>
												</xsl:when>
												<xsl:when
													test="../*[name()=concat('A_RelToOwner_CBN',$pos)] 
													= '1009900001'">
													<RelationDescription tc="1009900004">Friend
													</RelationDescription>
												</xsl:when>
												<xsl:when
													test="../*[name()=concat('A_RelToOwner_CBN',$pos)] 
													= '1000500012'">
													<RelationDescription tc="1000500013">No Relation
													</RelationDescription>
												</xsl:when>
												<xsl:when
													test="../*[name()=concat('A_RelToOwner_CBN',$pos)] 
													= '9999'">
													<RelationDescription tc="1000500023">Unknown
													</RelationDescription>
												</xsl:when>
												<xsl:when
													test="../*[name()=concat('A_RelToOwner_CBN',$pos)] 
													= '1000500014'">
													<RelationDescription tc="1000500012">Children
													</RelationDescription>
												</xsl:when>
												<xsl:when
													test="../*[name()=concat('A_RelToOwner_CBN',$pos)] = '13'">
													<RelationDescription tc="1000500012">Children
													</RelationDescription>
												</xsl:when>
												<xsl:when
													test="../*[name()=concat('A_RelToOwner_CBN',$pos)] 
													= '2'">
													<RelationDescription tc="1000500011">Estate of
														Insured
													</RelationDescription>
												</xsl:when>
												<xsl:when
													test="../*[name()=concat('A_RelToOwner_CBN',$pos)] = '20'">
													<RelationDescription tc="1000500006">Parents
													</RelationDescription>
												</xsl:when>
												<xsl:when
													test="../*[name()=concat('A_RelToOwner_CBN',$pos)] = '4'">
													<RelationDescription tc="1000500017">Creditors
													</RelationDescription>
												</xsl:when>
												<xsl:when
													test="../*[name()=concat('A_RelToOwner_CBN',$pos)] 
													= '51'">
													<RelationDescription tc="1000500004">Corporation
													</RelationDescription>
												</xsl:when>
												<xsl:when
													test="../*[name()=concat('A_RelToOwner_CBN',$pos)] = '7'">
													<RelationDescription tc="1000500019">Trust
													</RelationDescription>
												</xsl:when>
												<xsl:when
													test="../*[name()=concat('A_RelToOwner_CBN',$pos)] 
													= '9'">
													<RelationDescription tc="900">Spouse
													</RelationDescription>
												</xsl:when>
												<xsl:when
													test="../*[name()=concat('A_RelToOwner_CBN',$pos)] 
													= '1000500011'">
													<RelationDescription tc="1000500009">Grandparent
													</RelationDescription>
												</xsl:when>
											</xsl:choose>
											<InterestPercent>
												<xsl:value-of
													select="../*[name()=concat('A_InterestPercent_CBN',$pos)]" />
											</InterestPercent>
											<BeneficiaryDesignation>
												<xsl:attribute name="tc">
															<xsl:value-of
													select="../*[name()=concat('A_RelToOwner_CBN',$pos)]" />
														</xsl:attribute>
												<xsl:value-of
													select="../*[name()=concat('A_RelToOwner_CBN',$pos, '_Desc')]" />
											</BeneficiaryDesignation>
											<OLifEExtension
												ExtensionCode="Relation 2.8.90" VendorCode="05">
												<RelationExtension>
													<BeneficiaryDistributionOption
														tc="2">Percentage</BeneficiaryDistributionOption>
												</RelationExtension>
											</OLifEExtension>
										</Relation>
									</xsl:if>
								</xsl:if>
							</xsl:if>
						</xsl:if>
					</xsl:for-each>
					<!-- Payor Relation -->
					<xsl:if
						test="(./instanceData/TXLife/A_PremPayor ='1' or 
						./instanceData/TXLife/A_PremPayor = '2' or 
						./instanceData/TXLife/A_PremPayor = '3' or
						./instanceData/TXLife/A_PremPayor = '4' or
						./instanceData/TXLife/A_PremPayor = '5')">
						<Relation id="Relation_PAYOR"
							OriginatingObjectID="Holding_1">
							<xsl:if
								test="(./instanceData/TXLife/A_PremPayor !='-1' and ./instanceData/TXLife/A_PremPayor = '1') ">
								<xsl:attribute name="RelatedObjectID">Party_PINS</xsl:attribute>
							</xsl:if>
							<xsl:if
								test="(./instanceData/TXLife/A_PremPayor !='-1' and ./instanceData/TXLife/A_PremPayor = '2') ">
								<xsl:attribute name="RelatedObjectID">Party_JNT</xsl:attribute>
							</xsl:if>
							<xsl:if
								test="(./instanceData/TXLife/A_PremPayor !='-1' and ./instanceData/TXLife/A_PremPayor = '3') ">
								<xsl:if
									test="(./instanceData/TXLife/A_OwnerType = '2' and string-length(./instanceData/TXLife/A_EntityName_OWN)>0 )">
									<xsl:attribute name="RelatedObjectID">Party_ENTITY</xsl:attribute>
								</xsl:if>
								<xsl:if
									test="(./instanceData/TXLife/A_OwnerType = '1' and 
								(string-length(./instanceData/TXLife/A_FirstName_OWN) > 0 or
								string-length(./instanceData/TXLife/A_LastName_OWN) > 0))">
									<xsl:attribute name="RelatedObjectID">Party_OWN</xsl:attribute>
								</xsl:if>
							</xsl:if>
							<xsl:if
								test="(./instanceData/TXLife/A_PremPayor !='-1' and ./instanceData/TXLife/A_PremPayor = '4') ">
								<xsl:attribute name="RelatedObjectID">Party_JointOwn</xsl:attribute>
							</xsl:if>
							<xsl:if
								test="(./instanceData/TXLife/A_PayorType) !='-1' and (./instanceData/TXLife/A_PremPayor) ='5' and 
										(string-length(./instanceData/TXLife/A_EntityName_PYR)  >  0 or
										string-length(./instanceData/TXLife/A_FirstName_PYR)  >  0 or
										string-length(./instanceData/TXLife/A_LastName_PYR)  >  0 ) ">
								<xsl:attribute name="RelatedObjectID">Party_PYR</xsl:attribute>
							</xsl:if>
							<OriginatingObjectType tc="4">Holding
							</OriginatingObjectType>
							<RelatedObjectType tc="6">Party
							</RelatedObjectType>
							<RelationRoleCode tc="31">Payor</RelationRoleCode>
							<xsl:if
								test="(./instanceData/TXLife/A_PremPayor!='-1' and ./instanceData/TXLife/A_PremPayor = '1') ">
								<RelationDescription tc="91">Self
								</RelationDescription><!-- Citation Required for GIB -->
							</xsl:if>
							<xsl:if
								test="(./instanceData/TXLife/A_PremPayor!='-1' and ./instanceData/TXLife/A_PremPayor = '2') ">
								<RelationDescription tc="900">Spouse
								</RelationDescription>
							</xsl:if>
							<!-- <xsl:if test="(./instanceData/TXLife/A_PremPayor!='-1' and ./instanceData/TXLife/A_PremPayor 
								= '3') "> <RelationDescription tc="900">Spouse</RelationDescription> </xsl:if> 
								<xsl:if test="(./instanceData/TXLife/A_PremPayor!='-1' and ./instanceData/TXLife/A_PremPayor 
								= '4') "> <RelationDescription tc="900">Spouse</RelationDescription> </xsl:if> -->
							<xsl:if
								test="(./instanceData/TXLife/A_PremPayor!='-1' and ./instanceData/TXLife/A_PremPayor = '5')">
								<xsl:if test="./instanceData/TXLife/A_RelToPI_PYR!='-1'">
									<xsl:choose>
										<xsl:when
											test="./instanceData/TXLife/A_RelToPI_PYR = '1009900009'">
											<RelationDescription tc="1000500006">Parents
											</RelationDescription>
										</xsl:when>
										<xsl:when
											test="./instanceData/TXLife/A_RelToPI_PYR = '1009900008'">
											<RelationDescription tc="1000500018">Employer
											</RelationDescription>
										</xsl:when>
										<xsl:when
											test="./instanceData/TXLife/A_RelToPI_PYR = '1009900007'">
											<RelationDescription tc="1009900007">Irrevocable
												Trustee
											</RelationDescription>
										</xsl:when>
										<xsl:when
											test="./instanceData/TXLife/A_RelToPI_PYR = '1009900006'">
											<RelationDescription tc="1000500014">Business
												Associate
											</RelationDescription>
										</xsl:when>
										<xsl:when
											test="./instanceData/TXLife/A_RelToPI_PYR = '1009900005'">
											<RelationDescription tc="1000500012">Children
											</RelationDescription>
										</xsl:when>
										<xsl:when
											test="./instanceData/TXLife/A_RelToPI_PYR = '1009900004'">
											<RelationDescription tc="1000500009">Grandparent
											</RelationDescription>
										</xsl:when>
										<xsl:when
											test="./instanceData/TXLife/A_RelToPI_PYR = '1009900003'">
											<RelationDescription tc="900">Spouse
											</RelationDescription>
										</xsl:when>
										<xsl:when
											test="./instanceData/TXLife/A_RelToPI_PYR = '1009900002'">
											<RelationDescription tc="1000500015">Partner
											</RelationDescription>
										</xsl:when>
										<xsl:when
											test="./instanceData/TXLife/A_RelToPI_PYR = '1009900001'">
											<RelationDescription tc="91">Self
											</RelationDescription>
										</xsl:when>
									</xsl:choose>
								</xsl:if>
							</xsl:if>
						</Relation>
					</xsl:if>
					<!-- AGT Relation Holding/Party -->
					<xsl:for-each select="instanceData/TXLife/*">
						<xsl:if test="starts-with(name(),'A_AgentID_AGT')">
							<xsl:if test="string-length(.) > 0">
								<xsl:variable name="pos"
									select="substring(name(),14)" />
								<xsl:variable name="agentValue"
									select='format-number(../*[name()="A_COUNT_TOTAL_AGT"], "0")' />
								<xsl:variable name="posValue"
									select='format-number($pos, "0")' />
								<xsl:if test="$pos != '' and $posValue &lt;= $agentValue">
									<xsl:if
										test="string-length(../*[name()=concat('A_FirstName_AGT',$pos)])>0 or 
											string-length(../*[name()=concat('A_LastName_AGT',$pos)])>0">
										<Relation OriginatingObjectID="Holding_1">
											<xsl:attribute name="RelatedObjectID">
														<xsl:value-of
												select="concat('Party_AGT',$pos)" />
													</xsl:attribute>
											<xsl:attribute name="id">
														<xsl:value-of
												select="concat('Relation_AGT',$pos)" />
													</xsl:attribute>
											<OriginatingObjectType tc="4">Holding
											</OriginatingObjectType>
											<RelatedObjectType tc="6">Party
											</RelatedObjectType>
											<xsl:if test="$posValue = '1'">
												<RelationRoleCode tc="37">Primary Writing Agent
												</RelationRoleCode>
											</xsl:if>
											<xsl:if test="$posValue != '1'">
												<RelationRoleCode tc="52">Additional Writing
													Agent
												</RelationRoleCode>
											</xsl:if>
											<InterestPercent>
												<xsl:value-of
													select="../*[name()=concat('A_InterestPercent_AGT',$pos)]" />
											</InterestPercent>
											<OLifEExtension
												ExtensionCode="Relation 2.8.90" VendorCode="05">
												<RelationProducerExtension>
													<!-- BHFD-529 -->
													<!-- <xsl:if test="string-length(../*[name()=concat('A_ProfileCode_AGT',$pos)])>0 
														"> <SituationCode> <xsl:value-of select="../*[name()=concat('A_ProfileCode_AGT',$pos)]" 
														/> </SituationCode> </xsl:if> -->
													<xsl:if
														test="$posValue = '1' and ../*[name()=concat('A_CompPlan_AGT',$pos)]!='-1'">
														<CommissionOptCode>
															<xsl:attribute name="tc">
														<xsl:value-of
																select="../*[name()=concat('A_CompPlan_AGT',$pos)]" />
													</xsl:attribute>
															<xsl:value-of
																select="../*[name()=concat('A_CompPlan_AGT',$pos,'_Desc')]" />
														</CommissionOptCode>
													</xsl:if>
												</RelationProducerExtension>
											</OLifEExtension>
										</Relation>
									</xsl:if>
								</xsl:if>
							</xsl:if>
						</xsl:if>
					</xsl:for-each>
					<!--Form Instance and Relation for Application Version -->
					<xsl:if
						test="string-length(./instanceData/TXLife/A_ApplicationVersion)>0">
						<FormInstance id="FormInstance_1"
							RelatedObjectID="Party_PINS">
							<ProviderFormNumber>
								<xsl:value-of
									select="./instanceData/TXLife/A_ApplicationVersion" />
							</ProviderFormNumber>
						</FormInstance>
						<Relation id="Relation_Form_1"
							OriginatingObjectID="FormInstance_1" RelatedObjectID="Party_PINS">
							<OriginatingObjectType tc="101">FormInstance
							</OriginatingObjectType>
							<RelatedObjectType tc="6">Party</RelatedObjectType>
							<RelationRoleCode tc="107">Form For</RelationRoleCode>
						</Relation>
					</xsl:if>
				</OLifE>
			</TXLifeRequest>
		</TXLife>
	</xsl:template>
	<xsl:template name="FormatDate">
		<xsl:param name="DateString" />
		<xsl:param name="Separator" />
		<xsl:param name="FormatType-In" />
		<xsl:param name="FormatType-Out" />
		<xsl:param name="AttribName" />
		<xsl:choose>
			<xsl:when test="contains($DateString, $Separator)">
				<xsl:variable name="day"
					select="substring-before(substring-after($DateString,$Separator),$Separator)" />
				<xsl:variable name="month"
					select="substring-before($DateString,$Separator)" />
				<xsl:variable name="year"
					select="substring($DateString, string-length($DateString)-3, string-length($DateString))" />
				<xsl:value-of
					select="concat($year,'-',$month,'-',$day)" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$DateString" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="FormatCurrency">
		<xsl:param name="currString" />
		<xsl:value-of select="translate($currString,'$,','')" />
	</xsl:template>
</xsl:stylesheet>