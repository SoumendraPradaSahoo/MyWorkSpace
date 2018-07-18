<!-- CHANGE LOG -->
<!-- Audit Number Version Change Description -->
<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:java="http://xml.apache.org/xslt/java">
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
		<xsl:variable name="uid" select="java:java.util.UUID.randomUUID()" />
		<TXLife xmlns:java="http://xml.apache.org/xslt/java" xmlns:xsd="http://www.w3.org/2001/XMLSchema"
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
						<xsl:if test="./instanceData/TXLife/A_RestrictionCode =  '1'">
							<RestrictionCode tc="1009900001">Contingent</RestrictionCode>
						</xsl:if>
						<xsl:if test="./instanceData/TXLife/A_RestrictionCode =  '2'">
							<RestrictionCode tc="1009900002">Multiple Trustees
							</RestrictionCode>
						</xsl:if>
						<Policy>
							<xsl:if test="string-length(instanceData/TXLife/A_PolNumber)>0">
								<PolNumber>
									<xsl:value-of select="instanceData/TXLife/A_PolNumber" />
								</PolNumber>
							</xsl:if>
							<LineOfBusiness tc="1">Life</LineOfBusiness>
							<ProductType tc="5">Indexed Universal Life</ProductType>
							<ProductCode>
								<xsl:value-of select="instanceData/TXLife/A_ProductCode_IUL" />
							</ProductCode>
							<CarrierCode>BHF</CarrierCode>
							<ReplacementType>
								<xsl:attribute name="tc">
									<xsl:value-of
									select="instanceData/TXLife/A_ReplacmentType_LifeHolding" />
								</xsl:attribute>
								<xsl:value-of
									select="instanceData/TXLife/A_ReplacmentType_LifeHolding_Desc" />
							</ReplacementType>
							<xsl:if test="./instanceData/TXLife/A_PaymentMode != '9'">
								<PaymentMode>
									<xsl:attribute name="tc">
										<xsl:value-of select="instanceData/TXLife/A_PaymentMode" />
									</xsl:attribute>
									<xsl:value-of select="instanceData/TXLife/A_PaymentMode_Desc" />
								</PaymentMode>
							</xsl:if>
							<xsl:choose>
								<xsl:when test="contains(instanceData/TXLife/A_PremiumWA ,'$')">
									<PaymentAmt>
										<xsl:value-of
											select="translate(substring-after(instanceData/TXLife/A_PremiumWA, '$'),',','')" />
									</PaymentAmt>
								</xsl:when>
								<xsl:when test="not(contains(instanceData/TXLife/A_PremiumWA ,'$'))">
									<PaymentAmt>
										<xsl:value-of
											select="translate(instanceData/TXLife/A_PremiumWA,',','')" />
									</PaymentAmt>
								</xsl:when>
							</xsl:choose>
							<xsl:choose>
								<xsl:when test="./instanceData/TXLife/A_Wire_MPREM = '1009900004' ">
									<PaymentMethod tc="2">Wire Transfer</PaymentMethod>
								</xsl:when>
								<xsl:when test="./instanceData/TXLife/A_Check_MPREM = '1009900003' ">
									<PaymentMethod tc="2">Check</PaymentMethod>
								</xsl:when>
								<xsl:when test="./instanceData/TXLife/A_EFT_MPREM = '7' ">
									<PaymentMethod tc="7">Electronic Fund Transfer
									</PaymentMethod>
								</xsl:when>
								<xsl:when test="./instanceData/TXLife/TXLife/A_PaymentMode = '9'">
									<PaymentMethod tc="20">Single Premium</PaymentMethod>
								</xsl:when>
							</xsl:choose>
							<xsl:if
								test="./instanceData/TXLife/A_PaymentMethod = '7' and ./instanceData/TXLife/A_WithdrawalOpt = '2'">
								<PaymentDraftDay>
									<xsl:value-of select="instanceData/TXLife/A_WithdrawalDay" />
								</PaymentDraftDay>
							</xsl:if>
							<Life>
								<QualPlanType tc="1">NonQualified</QualPlanType>
								<!-- modified by Puja -->
								<xsl:if
									test="string-length(instanceData/TXLife/A_AmtCollected_TIA)>0 ">
									<xsl:choose>
										<xsl:when
											test="contains(instanceData/TXLife/A_AmtCollected_TIA ,'$')">
											<InitialPremAmt>
												<xsl:value-of
													select="translate(substring-after(instanceData/TXLife/A_AmtCollected_TIA, '$'),',','')" />
											</InitialPremAmt>
										</xsl:when>
										<xsl:when
											test="not(contains(instanceData/TXLife/A_AmtCollected_TIA ,'$'))">
											<InitialPremAmt>
												<xsl:value-of
													select="translate(instanceData/TXLife/A_AmtCollected_TIA,',','')" />
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
								<!--xsl:otherwise> <ReplacementType tc="3">External</ReplacementType> 
									</xsl:otherwise -->
								<!-- modified by Puja -->
								<Coverage id="Coverage_1">
									<ProductCode>
										<xsl:value-of select="instanceData/TXLife/A_ProductCode_IUL" />
									</ProductCode>
									<LifeCovStatus tc="1">Active</LifeCovStatus>
									<xsl:if test="./instanceData/TXLife/A_TobaccoInd_PINS = '0'">
										<TobaccoPremiumBasis tc="1">Non Smoker
										</TobaccoPremiumBasis>
									</xsl:if>
									<xsl:if test="./instanceData/TXLife/A_TobaccoInd_PINS = '1'">
										<TobaccoPremiumBasis tc="2">Smoker
										</TobaccoPremiumBasis>
									</xsl:if>
									<xsl:choose>
										<xsl:when test="./instanceData/TXLife/A_EstatePlan = '8'">
											<Purpose>
												<xsl:attribute name="tc">
												<xsl:value-of select="instanceData/TXLife/A_EstatePlan" />
											</xsl:attribute>
												Estate Planning
											</Purpose>
										</xsl:when>
										<xsl:when test="./instanceData/TXLife/A_CharitableGiving = '9'">
											<Purpose>
												<xsl:attribute name="tc">
												<xsl:value-of select="instanceData/TXLife/A_CharitableGiving" />
											</xsl:attribute>
												Charitable Giving
											</Purpose>
										</xsl:when>
										<xsl:when test="./instanceData/TXLife/A_KeyPerson = '14'">
											<Purpose>
												<xsl:attribute name="tc">
												<xsl:value-of select="instanceData/TXLife/A_KeyPerson" />
											</xsl:attribute>
												Key Person
											</Purpose>
										</xsl:when>
										<xsl:when test="./instanceData/TXLife/A_MortgagePro = '32'">
											<Purpose>
												<xsl:attribute name="tc">
												<xsl:value-of select="instanceData/TXLife/A_MortgagePro" />
											</xsl:attribute>
												Mortgage Protection
											</Purpose>
										</xsl:when>
										<xsl:when test="./instanceData/TXLife/A_ExecutuveBonus = '16'">
											<Purpose>
												<xsl:attribute name="tc">
												<xsl:value-of select="instanceData/TXLife/A_ExecutuveBonus" />
											</xsl:attribute>
												Executive Bonus
											</Purpose>
										</xsl:when>
										<xsl:when test="./instanceData/TXLife/A_BuySell = '15'">
											<Purpose>
												<xsl:attribute name="tc">
												<xsl:value-of select="instanceData/TXLife/A_BuySell" />
											</xsl:attribute>
												Buy/Sell
											</Purpose>
										</xsl:when>
										<xsl:when test="./instanceData/TXLife/A_IncomePro = '21'">
											<Purpose>
												<xsl:attribute name="tc">
												<xsl:value-of select="instanceData/TXLife/A_IncomePro" />
											</xsl:attribute>
												Income Protection
											</Purpose>
										</xsl:when>
										<xsl:when test="./instanceData/TXLife/A_BusinessNeeds = '3'">
											<Purpose>
												<xsl:attribute name="tc">
												<xsl:value-of select="instanceData/TXLife/A_BusinessNeeds" />
											</xsl:attribute>
												Business Needs - Other
											</Purpose>
										</xsl:when>
										<xsl:when test="./instanceData/TXLife/A_POIOther = '2147483647'">
											<Purpose>
												<xsl:attribute name="tc">
												<xsl:value-of select="instanceData/TXLife/A_POIOther" />
											</xsl:attribute>
												<xsl:value-of select="instanceData/TXLife/A_POIOtherDetails" />
											</Purpose>
										</xsl:when>
									</xsl:choose>
									<IndicatorCode tc="1">Base</IndicatorCode>
									<LivesType tc="1">Single Life</LivesType>
									<DeathBenefitOptType tc="1">Level
									</DeathBenefitOptType>
									<xsl:choose>
										<xsl:when
											test="contains(instanceData/TXLife/A_CurrentAmt_IUL ,'$')">
											<CurrentAmt>
												<xsl:value-of
													select="translate(substring-after(instanceData/TXLife/A_CurrentAmt_IUL, '$'),',','')" />
											</CurrentAmt>
										</xsl:when>
										<xsl:when
											test="not(contains(instanceData/TXLife/A_CurrentAmt_IUL ,'$'))">
											<CurrentAmt>
												<xsl:value-of
													select="translate(instanceData/TXLife/A_CurrentAmt_IUL,',','')" />
											</CurrentAmt>
										</xsl:when>
									</xsl:choose>
									<!-- RIDERS IMPLEMENTATION -->
									<xsl:if test="string-length(instanceData/TXLife/A_LTCR_IUL)>0">
										<CovOption id="CovOption_LTCR_1">
											<ProductCode>
												<xsl:value-of select="$LTCR" />
											</ProductCode>
											<LifeCovOptTypeCode tc="30">Long Term Care
											</LifeCovOptTypeCode>
											<OLifEExtension VendorCode="05" ExtensionCode="CovOption 2.8.90">
												<CovOptionExtension>
													<xsl:if
														test="string-length(instanceData/TXLife/A_LTCR_Duration_IUL)>0">
														<Duration>
															<xsl:value-of select="instanceData/TXLife/A_LTCR_Duration_IUL" />
														</Duration>
													</xsl:if>
												</CovOptionExtension>
											</OLifEExtension>
										</CovOption>
									</xsl:if>
									<xsl:if test="string-length(instanceData/TXLife/A_EOBR_IUL)>0">
										<CovOption id="CovOption_EOBR_1">
											<ProductCode>
												<xsl:value-of select="$EOBR" />
											</ProductCode>
											<LifeCovOptTypeCode tc="31">Extension of
												Benefits Rider
											</LifeCovOptTypeCode>
											<OLifEExtension VendorCode="05" ExtensionCode="CovOption 2.8.90">
												<CovOptionExtension>
													<xsl:if
														test="string-length(instanceData/TXLife/A_EOBR_Duration_IUL )>0">
														<Duration>
															<xsl:value-of select="instanceData/TXLife/A_EOBR_Duration_IUL" />
														</Duration>
													</xsl:if>
												</CovOptionExtension>
											</OLifEExtension>
										</CovOption>
									</xsl:if>
									<xsl:if test="string-length(instanceData/TXLife/A_ILTCR_IUL)>0">
										<CovOption id="CovOption_ILTCR_1">
											<ProductCode><!-- BHFD-1294 -->
												<xsl:value-of select="$ILTCR" />
											</ProductCode>
											<LifeCovOptTypeCode tc="1009900002">Extension of
												Benefits for Long- Term Care with Inflation Coverage
											</LifeCovOptTypeCode>
											<OLifEExtension VendorCode="05" ExtensionCode="CovOption 2.8.90">
												<CovOptionExtension>
													<xsl:if
														test="string-length(instanceData/TXLife/A_ILTCR_Duration_IUL)>0">
														<Duration>
															<xsl:value-of select="instanceData/TXLife/A_ILTCR_Duration_IUL" />
														</Duration>
													</xsl:if>
												</CovOptionExtension>
											</OLifEExtension>
										</CovOption>
									</xsl:if>
									<xsl:if test="string-length(instanceData/TXLife/A_IndexLTCR_IUL)>0">
										<CovOption id="CovOption_IndexLTCR_1">
											<ProductCode><!-- BHFD-1294 -->
												<xsl:value-of select="$IndexLTCR" />
											</ProductCode>
											<LifeCovOptTypeCode tc="1009900003">Extension of
												Benefits for Long-Term Care with Index Coverage Rider
											</LifeCovOptTypeCode>
											<OLifEExtension VendorCode="05" ExtensionCode="CovOption 2.8.90">
												<CovOptionExtension>
													<xsl:if
														test="string-length(instanceData/TXLife/A_IndexLTCR_Duration_IUL)>0">
														<Duration>
															<xsl:value-of
																select="instanceData/TXLife/A_IndexLTCR_Duration_IUL" />
														</Duration>
													</xsl:if>
												</CovOptionExtension>
											</OLifEExtension>
										</CovOption>
									</xsl:if>
									<LifeParticipant id="LifeParticipant_1"
										PartyID="Party_PINS">
										<LifeParticipantRoleCode tc="1">Primary
											Insured
										</LifeParticipantRoleCode>
										<OLifEExtension VendorCode="05"
											ExtensionCode="LifeParticipant 2.8.90">
											<LifeParticipantExtension>
												<xsl:if test="(./instanceData/TXLife/A_TobaccoInd_PINS) = '0'">
													<ProposedTobaccoPremiumBasis
														tc="1">Non Smoker</ProposedTobaccoPremiumBasis>
												</xsl:if>
												<xsl:if test="(./instanceData/TXLife/A_TobaccoInd_PINS) = '1'">
													<ProposedTobaccoPremiumBasis
														tc="2">Smoker</ProposedTobaccoPremiumBasis>
												</xsl:if>
												<xsl:if test="(./instanceData/TXLife/A_Gender_PINS) = '3'">
													<NonbinaryInd tc="1">True</NonbinaryInd>
												</xsl:if>
											</LifeParticipantExtension>
										</OLifEExtension>
									</LifeParticipant>
								</Coverage>
								<LifeUSA>
									<DefLifeInsMethod>
										<xsl:attribute name="tc">
											<xsl:value-of select="$DefLifeInsMethodtc" />
										</xsl:attribute>
										<xsl:value-of select="$DefLifeInsMethod" />
									</DefLifeInsMethod>
									<!-- BHFD-530 -->
									<xsl:if test="./instanceData/TXLife/A_Internal1035 = '1'">
										<Internal1035 tc="1">true</Internal1035>
									</xsl:if>
									<xsl:if test="./instanceData/TXLife/A_Internal1035 = '0'">
										<Internal1035 tc="0">false</Internal1035>
									</xsl:if>
								</LifeUSA>
							</Life>
							<ApplicationInfo>
								<ApplicationType tc="1">New</ApplicationType>
								<ApplicationJurisdiction>
									<xsl:attribute name="tc">
										<xsl:value-of select="instanceData/TXLife/A_ApplicationJurisdiction" />
									</xsl:attribute>
									<xsl:value-of
										select="instanceData/TXLife/A_ApplicationJurisdiction_Desc" />
								</ApplicationJurisdiction>
								<FormalAppInd tc="1">True</FormalAppInd>
								<xsl:if test="./instanceData/TXLife/A_SignatureMethod = '1'">
									<!-- wet signature paper warp case -->
									<xsl:choose>
										<xsl:when
											test="string-length(instanceData/TXLife/A_SignatureDate)>0">
											<SignedDate>
												<xsl:call-template name="FormatDate">
													<xsl:with-param name="Separator">
														/
													</xsl:with-param>
													<xsl:with-param name="DateString">
														<xsl:value-of select="instanceData/TXLife/A_SignatureDate" />
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
										<xsl:value-of select="$current_date" />
									</SubmissionDate>
									<SubmissionTime>
										<xsl:value-of select="$current_time" />
									</SubmissionTime>
									<SubmissionType tc="1">Paper</SubmissionType>
								</xsl:if>
								<xsl:if test="./instanceData/TXLife/A_SignatureMethod = '1'">
									<!-- Paper Wrap Case -->
									<xsl:if test="./instanceData/TXLife/A_PISignatureOK = '0'">
										<AppProposedInsuredSignatureOK
											tc="0">false</AppProposedInsuredSignatureOK>
										<xsl:if test="./instanceData/TXLife/A_PIOtherThanOwn = '0'">
											<!-- owner is same as PINS -->
											<AppOwnerSignatureOK tc="0">false
											</AppOwnerSignatureOK>
										</xsl:if>
									</xsl:if>
									<xsl:if test="./instanceData/TXLife/A_PISignatureOK = '1'">
										<AppProposedInsuredSignatureOK
											tc="1">true</AppProposedInsuredSignatureOK>
										<xsl:if test="./instanceData/TXLife/A_PIOtherThanOwn = '0'">
											<!-- owner is same as PINS -->
											<AppOwnerSignatureOK tc="1">true
											</AppOwnerSignatureOK>
										</xsl:if>
									</xsl:if>
									<xsl:if test="./instanceData/TXLife/A_PIOtherThanOwn = '1'">
										<!-- owner and PINS are diffrent -->
										<xsl:if test="./instanceData/TXLife/A_OwnerSignatureOK = '0'">
											<AppOwnerSignatureOK tc="0">false
											</AppOwnerSignatureOK>
										</xsl:if>
										<xsl:if test="./instanceData/TXLife/A_OwnerSignatureOK = '1'">
											<AppOwnerSignatureOK tc="1">true
											</AppOwnerSignatureOK>
										</xsl:if>
									</xsl:if>
									<xsl:if test="./instanceData/TXLife/A_ProducerSignatureOK = '0'">
										<AppWritingAgentSignatureOK tc="0">false
										</AppWritingAgentSignatureOK>
									</xsl:if>
									<xsl:if test="./instanceData/TXLife/A_ProducerSignatureOK = '1'">
										<AppWritingAgentSignatureOK tc="1">true
										</AppWritingAgentSignatureOK>
									</xsl:if>
								</xsl:if>
								<xsl:choose>
									<xsl:when
										test="./instanceData/TXLife/A_ChangeExistingPolicyInd_PINS	= '1'">
										<ReplacementInd tc="1">true</ReplacementInd>
									</xsl:when>
									<xsl:otherwise>
										<ReplacementInd tc="0">false</ReplacementInd>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:if test="./instanceData/TXLife/A_ReplacmentInd_AGT1 != '1'">
									<ProducerReplacementDisclosureInd
										tc="0">false</ProducerReplacementDisclosureInd>
								</xsl:if>
								<xsl:if test="./instanceData/TXLife/A_ReplacmentInd_AGT1 = '1'">
									<ProducerReplacementDisclosureInd
										tc="1">true</ProducerReplacementDisclosureInd>
								</xsl:if>
								<SignatureInfo id="SignatureInfo_1">
									<SignatureRoleCode tc="18">Owner
									</SignatureRoleCode>
									<xsl:if test="./instanceData/TXLife/A_SignatureMethod = '1'">
										<xsl:if test="string-length(instanceData/TXLife/A_SignatureDate)>0">
											<SignatureDate>
												<xsl:call-template name="FormatDate">
													<xsl:with-param name="Separator">
														/
													</xsl:with-param>
													<xsl:with-param name="DateString">
														<xsl:value-of select="instanceData/TXLife/A_SignatureDate" />
													</xsl:with-param>
												</xsl:call-template>
											</SignatureDate>
										</xsl:if>
									</xsl:if>
									<!-- Updated by Puja moved the tag below Signature Date -->
									<xsl:if test="./instanceData/TXLife/A_SignatureMethod = '1'">
										<SignatureCity>
											<xsl:value-of select="instanceData/TXLife/A_SignatureCity" />
										</SignatureCity>
									</xsl:if>
									<!-- Updated by Puja -->
								</SignatureInfo>
								<OLifEExtension VendorCode="05"
									ExtensionCode="ApplicationInfo 2.8.90">
									<ApplicationInfoExtension>
										<!-- BHFD-1109 -->
										<xsl:if test="./instanceData/TXLife/A_ExistingInsInd_AGT1 = '1'">
											<ProducerOtherInsDisclosureInd
												tc="1">True</ProducerOtherInsDisclosureInd>
										</xsl:if>
										<xsl:if test="./instanceData/TXLife/A_ExistingInsInd_AGT1 = '0'">
											<ProducerOtherInsDisclosureInd
												tc="0">False</ProducerOtherInsDisclosureInd>
										</xsl:if>
										<!-- <xsl:if test="./instanceData/TXLife/A_ExistingInsInd_AGT1 
											= '2'"> <ProducerOtherInsDisclosureInd tc="1009900001">NA</ProducerOtherInsDisclosureInd> 
											</xsl:if> -->
										<xsl:if test="./instanceData/TXLife/A_MedReqOrdered_AGT1 = '1'">
											<BypassReqOrderInd tc="1">True
											</BypassReqOrderInd>
										</xsl:if>
										<xsl:if test="./instanceData/TXLife/A_MedReqOrdered_AGT1 != '1'">
											<xsl:if test="./instanceData/TXLife/A_MedReqNotOrdered_AGT1 = '1'">
												<BypassReqOrderInd tc="0">False
												</BypassReqOrderInd>
											</xsl:if>
										</xsl:if>
										<xsl:if test="./instanceData/TXLife/A_ApplicationCompInd = '1'">
											<AppCompUSInd tc="1">True</AppCompUSInd>
										</xsl:if>
										<xsl:if test="./instanceData/TXLife/A_ApplicationCompInd != '1'">
											<AppCompUSInd tc="0">False</AppCompUSInd>
										</xsl:if>
										<!-- BHFD-1180 and 1083 -->
										<xsl:if test="./instanceData/TXLife/A_GuardianSignatureOK = '1'">
											<AppParentSignatureOKInd tc="1">True
											</AppParentSignatureOKInd>
										</xsl:if>
										<xsl:if test="./instanceData/TXLife/A_GuardianSignatureOK = '0'">
											<AppParentSignatureOKInd tc="0">False
											</AppParentSignatureOKInd>
										</xsl:if>
										<xsl:if test="./instanceData/TXLife/A_InsToOwner = '1'">
											<ChgInsToOwnerInd tc="1">True</ChgInsToOwnerInd>
										</xsl:if>
										<xsl:if test="./instanceData/TXLife/A_InsToOwner = '0'">
											<ChgInsToOwnerInd tc="0">False
											</ChgInsToOwnerInd>
										</xsl:if>
										<xsl:if test="./instanceData/TXLife/A_MedicaidCovInd = '1'">
											<CoveredByMedicaidInd tc="1">True
											</CoveredByMedicaidInd>
										</xsl:if>
										<xsl:if test="./instanceData/TXLife/A_MedicaidCovInd = '0'">
											<CoveredByMedicaidInd tc="0">False
											</CoveredByMedicaidInd>
										</xsl:if>
										<!--BHFD-1414-->
										<xsl:if
											test="string-length(instanceData/TXLife/A_LTCLapsedDetails)>0">
											<ExistingLTCLapse>
												<xsl:call-template name="FormatDate">
													<xsl:with-param name="Separator">
														/
													</xsl:with-param>
													<xsl:with-param name="DateString">
														<xsl:value-of select="instanceData/TXLife/A_LTCLapsedDetails" />
													</xsl:with-param>
												</xsl:call-template>
											</ExistingLTCLapse>
										</xsl:if>
										<xsl:if test="./instanceData/TXLife/A_Check_TIA = '1'">
											<InitPremCheckInd tc="1">true</InitPremCheckInd>
										</xsl:if>
										<xsl:if test="./instanceData/TXLife/A_EFT_TIA = '1'">
											<InitPremModePremFormInd tc="1">true
											</InitPremModePremFormInd>
										</xsl:if>
										<xsl:if test="./instanceData/TXLife/A_Wire_TIA = '1'">
											<InitPremWireInd tc="1">true</InitPremWireInd>
										</xsl:if>
										<xsl:if test="./instanceData/TXLife/A_BackupWithholdingInd = '1'">
											<IRSNoticeInd tc="1">True</IRSNoticeInd>
										</xsl:if>
										<xsl:if test="./instanceData/TXLife/A_BackupWithholdingInd = '0'">
											<IRSNoticeInd tc="0">False</IRSNoticeInd>
										</xsl:if>
										<xsl:if test="./instanceData/TXLife/A_AddNoticesInd = '1'">
											<LapseNoticeInd tc="1">True</LapseNoticeInd>
										</xsl:if>
										<xsl:if
											test="./instanceData/TXLife/A_AddNoticesNone = '1' and ./instanceData/TXLife/A_AddNoticesInd != '1'">
											<LapseNoticeInd tc="0">False</LapseNoticeInd>
										</xsl:if>
										<xsl:if test="./instanceData/TXLife/A_OtherLTCInforce = '1'">
											<LTCInforceInd tc="1">True</LTCInforceInd>
										</xsl:if>
										<xsl:if test="./instanceData/TXLife/A_OtherLTCInforce = '0'">
											<LTCInforceInd tc="0">False</LTCInforceInd>
										</xsl:if>
										<xsl:if test="./instanceData/TXLife/A_LTCLastYear = '1'">
											<LTCInforce12MonthsInd tc="1">True
											</LTCInforce12MonthsInd>
										</xsl:if>
										<xsl:if test="./instanceData/TXLife/A_LTCLastYear = '0'">
											<LTCInforce12MonthsInd tc="0">False
											</LTCInforce12MonthsInd>
										</xsl:if>
										<xsl:if test="./instanceData/TXLife/A_LTCReplacementInd = '1'">
											<LTCReplaceInd tc="1">True</LTCReplaceInd>
										</xsl:if>
										<xsl:if test="./instanceData/TXLife/A_LTCReplacementInd = '0'">
											<LTCReplaceInd tc="0">False</LTCReplaceInd>
										</xsl:if>
										<!-- NIGO indicator BHFD-1125 -->
										<xsl:if test="./instanceData/TXLife/A_NIGOInd =  '1'">
											<NIGOInd tc="1">True</NIGOInd>
										</xsl:if>
										<!--NIGOInd is optional field its only required for true value -->
										<!-- <xsl:if test="./instanceData/TXLife/A_NIGOInd = '0'"> <NIGOInd 
											tc="0">False</NIGOInd> </xsl:if> -->
										<xsl:if test="./instanceData/TXLife/A_OffPaymtInd_PINS = '1'">
											<OffPaymtForPolicyInd tc="1">True
											</OffPaymtForPolicyInd>
										</xsl:if>
										<xsl:if test="./instanceData/TXLife/A_OffPaymtInd_PINS != '1'">
											<OffPaymtForPolicyInd tc="0">False
											</OffPaymtForPolicyInd>
										</xsl:if>
										<!-- BHFD-1145 -->
										<xsl:if
											test="./instanceData/TXLife/A_OwnOffPaymtInd = '1' and ./instanceData/TXLife/A_PIOtherThanOwn = '1'">
											<OwnOffPaymtForPolicyInd tc="1">True</OwnOffPaymtForPolicyInd>
										</xsl:if>
										<xsl:if
											test="./instanceData/TXLife/A_OwnOffPaymtInd != '1' and ./instanceData/TXLife/A_PIOtherThanOwn = '1'">
											<OwnOffPaymtForPolicyInd tc="0">False</OwnOffPaymtForPolicyInd>
										</xsl:if>
										<xsl:if
											test="./instanceData/TXLife/A_InforceNAppliedfor_OWN1 = '1' and ./instanceData/TXLife/A_PIOtherThanOwn = '1'">
											<OwnPendingInsInd tc="1">True</OwnPendingInsInd>
										</xsl:if>
										<xsl:if
											test="./instanceData/TXLife/A_InforceNAppliedfor_OWN1 != '1' and ./instanceData/TXLife/A_PIOtherThanOwn = '1'">
											<OwnPendingInsInd tc="0">False
											</OwnPendingInsInd>
										</xsl:if>
										<xsl:if
											test="./instanceData/TXLife/A_InforceNAppliedfor_PINS 
											= '1' and ./instanceData/TXLife/A_PIOtherThanOwn != '1'">
											<OwnPendingInsInd tc="1">True</OwnPendingInsInd>
										</xsl:if>
										<xsl:if
											test="./instanceData/TXLife/A_InforceNAppliedfor_PINS 
											!= '1' and ./instanceData/TXLife/A_PIOtherThanOwn != '1'">
											<OwnPendingInsInd tc="0">False
											</OwnPendingInsInd>
										</xsl:if>
										<xsl:if test="./instanceData/TXLife/A_PIOtherThanOwn = '1'">
											<OwnSameAsInsuredInd tc="0">False
											</OwnSameAsInsuredInd>
										</xsl:if>
										<xsl:if test="./instanceData/TXLife/A_PIOtherThanOwn = '0'">
											<OwnSameAsInsuredInd tc="1">True
											</OwnSameAsInsuredInd>
										</xsl:if>
										<!-- BHFD-1145 -->
										<xsl:if
											test="./instanceData/TXLife/A_OwnSoldTransLifeInd = '1' and ./instanceData/TXLife/A_PIOtherThanOwn = '1'">
											<OwnSoldTransLifePolicyInd tc="1">True</OwnSoldTransLifePolicyInd>
										</xsl:if>
										<xsl:if
											test="./instanceData/TXLife/A_OwnSoldTransLifeInd != '1' and ./instanceData/TXLife/A_PIOtherThanOwn = '1'">
											<OwnSoldTransLifePolicyInd tc="0">False</OwnSoldTransLifePolicyInd>
										</xsl:if>
										<!-- BHFD-1145 -->
										<xsl:if
											test="./instanceData/TXLife/A_OwnSolicitedToSellInd = '1' and ./instanceData/TXLife/A_PIOtherThanOwn = '1'">
											<OwnSolicitedToSellInd tc="1">True</OwnSolicitedToSellInd>
										</xsl:if>
										<xsl:if
											test="./instanceData/TXLife/A_OwnSolicitedToSellInd != '1' and ./instanceData/TXLife/A_PIOtherThanOwn = '1'">
											<OwnSolicitedToSellInd tc="0">False</OwnSolicitedToSellInd>
										</xsl:if>
										<!-- BHFD-1225 moved to insured.Risk -->
										<!-- <xsl:if test="./instanceData/TXLife/A_InforceNAppliedfor_PINS 
											= '1'"> <PendingInsInd tc="1">True</PendingInsInd> </xsl:if> <xsl:if test="./instanceData/TXLife/A_InforceNAppliedfor_PINS 
											!= '1'"> <PendingInsInd tc="0">False</PendingInsInd> </xsl:if> -->
										<!-- BHFD-435 -->
										<!-- <xsl:if test="./instanceData/TXLife/A_HIVFormFormInd_AGT1 
											= '1'"> <ProducerHIVNotice tc="1">Yes</ProducerHIVNotice> </xsl:if> <xsl:if 
											test="./instanceData/TXLife/A_HIVFormFormInd_AGT1 = '0'"> <ProducerHIVNotice 
											tc="2">No</ProducerHIVNotice> </xsl:if> <xsl:if test="./instanceData/TXLife/A_HIVFormFormInd_AGT1 
											= '2'"> <ProducerHIVNotice tc="1009900001">NA</ProducerHIVNotice> </xsl:if> -->
										<xsl:if test="./instanceData/TXLife/A_SalesMaterialInd_AGT1 = '1'">
											<ProducerAppropSaleMatInd tc="1">True
											</ProducerAppropSaleMatInd>
										</xsl:if>
										<xsl:if test="./instanceData/TXLife/A_SalesMaterialInd_AGT1 = '0'">
											<ProducerAppropSaleMatInd tc="0">False
											</ProducerAppropSaleMatInd>
										</xsl:if>
										<xsl:if test="./instanceData/TXLife/A_1035ExchgFormInd_AGT1 = '1'">
											<ProducerAttach1035Form tc="1">Yes
											</ProducerAttach1035Form>
										</xsl:if>
										<xsl:if test="./instanceData/TXLife/A_1035ExchgFormInd_AGT1 = '0'">
											<ProducerAttach1035Form tc="2">No
											</ProducerAttach1035Form>
										</xsl:if>
										<xsl:if test="./instanceData/TXLife/A_1035ExchgFormInd_AGT1 = '2'">
											<ProducerAttach1035Form tc="1009900001">NA
											</ProducerAttach1035Form>
										</xsl:if>
										<xsl:if
											test="./instanceData/TXLife/A_ReplacementFormsInd_AGT1 = '1'">
											<ProducerCompReplForm tc="1">Yes
											</ProducerCompReplForm>
										</xsl:if>
										<xsl:if
											test="./instanceData/TXLife/A_ReplacementFormsInd_AGT1 = '0'">
											<ProducerCompReplForm tc="2">No
											</ProducerCompReplForm>
										</xsl:if>
										<xsl:if
											test="./instanceData/TXLife/A_ReplacementFormsInd_AGT1 = '2'">
											<ProducerCompReplForm tc="1009900001">NA
											</ProducerCompReplForm>
										</xsl:if>
										<!-- BHFD-435 -->
										<!-- <xsl:if test="./instanceData/TXLife/A_CritDisclosureFormInd_AGT1 
											= '1'"> <ProducerCritIllnessDiscl tc="1">Yes</ProducerCritIllnessDiscl> </xsl:if> 
											<xsl:if test="./instanceData/TXLife/A_CritDisclosureFormInd_AGT1 = '0'"> 
											<ProducerCritIllnessDiscl tc="2">No</ProducerCritIllnessDiscl> </xsl:if> 
											<xsl:if test="./instanceData/TXLife/A_CritDisclosureFormInd_AGT1 = '2'"> 
											<ProducerCritIllnessDiscl tc="1009900001">NA</ProducerCritIllnessDiscl> </xsl:if> -->
										<!-- <xsl:if test="./instanceData/TXLife/A_LifeGuideFormInd_AGT1 
											= '1'"> <ProducerLifeBuyerGdInd tc="1">Yes</ProducerLifeBuyerGdInd> </xsl:if> 
											<xsl:if test="./instanceData/TXLife/A_LifeGuideFormInd_AGT1 = '0'"> <ProducerLifeBuyerGdInd 
											tc="2">No</ProducerLifeBuyerGdInd> </xsl:if> <xsl:if test="./instanceData/TXLife/A_LifeGuideFormInd_AGT1 
											= '2'"> <ProducerLifeBuyerGdInd tc="1009900001">NA</ProducerLifeBuyerGdInd> 
											</xsl:if> <xsl:if test="./instanceData/TXLife/A_LongDisclosureFormInd_AGT1 
											= '1'"> <ProducerLTCDiscl tc="1">Yes</ProducerLTCDiscl> </xsl:if> <xsl:if 
											test="./instanceData/TXLife/A_LongDisclosureFormInd_AGT1 = '0'"> <ProducerLTCDiscl 
											tc="2">No</ProducerLTCDiscl> </xsl:if> <xsl:if test="./instanceData/TXLife/A_LongDisclosureFormInd_AGT1 
											= '2'"> <ProducerLTCDiscl tc="1009900001">NA</ProducerLTCDiscl> </xsl:if> 
											<xsl:if test="./instanceData/TXLife/A_PrivNoticeFormInd_AGT1 = '1'"> <ProducerPrivacyNotInd 
											tc="1">Yes</ProducerPrivacyNotInd> </xsl:if> <xsl:if test="./instanceData/TXLife/A_PrivNoticeFormInd_AGT1 
											= '0'"> <ProducerPrivacyNotInd tc="2">No</ProducerPrivacyNotInd> </xsl:if> 
											<xsl:if test="./instanceData/TXLife/A_PrivNoticeFormInd_AGT1 = '2'"> <ProducerPrivacyNotInd 
											tc="1009900001">NA</ProducerPrivacyNotInd> </xsl:if> -->
										<xsl:if test="./instanceData/TXLife/A_AppCompletion_AGT1 = '1'">
											<ProducerSeeAllPersonsInd tc="1">True
											</ProducerSeeAllPersonsInd>
										</xsl:if>
										<xsl:if test="./instanceData/TXLife/A_AppCompletion_AGT1 = '0'">
											<ProducerSeeAllPersonsInd tc="0">False
											</ProducerSeeAllPersonsInd>
										</xsl:if>
										<!-- BHFD-435 -->
										<!-- <xsl:if test="./instanceData/TXLife/A_TempReceiptFormInd_AGT1 
											= '1'"> <ProducerTIAReceipt tc="1">Yes</ProducerTIAReceipt> </xsl:if> <xsl:if 
											test="./instanceData/TXLife/A_TempReceiptFormInd_AGT1 = '0'"> <ProducerTIAReceipt 
											tc="2">No</ProducerTIAReceipt> </xsl:if> <xsl:if test="./instanceData/TXLife/A_TempReceiptFormInd_AGT1 
											= '2'"> <ProducerTIAReceipt tc="1009900001">NA</ProducerTIAReceipt> </xsl:if> -->
										<xsl:if test="./instanceData/TXLife/A_TobaccoInd_PINS = '1'">
											<SmokingInd tc="1">True</SmokingInd>
										</xsl:if>
										<xsl:if test="./instanceData/TXLife/A_TobaccoInd_PINS != '1'">
											<SmokingInd tc="0">False</SmokingInd>
										</xsl:if>
										<xsl:if test="./instanceData/TXLife/A_SoldTransLifeInd_PINS = '1'">
											<SoldTransLifePolicyInd tc="1">True
											</SoldTransLifePolicyInd>
										</xsl:if>
										<xsl:if test="./instanceData/TXLife/A_SoldTransLifeInd_PINS != '1'">
											<SoldTransLifePolicyInd tc="0">False
											</SoldTransLifePolicyInd>
										</xsl:if>
										<xsl:if
											test="./instanceData/TXLife/A_SolicitedToSellInd_PINS = '1'">
											<SolicitedToSellInd tc="1">True
											</SolicitedToSellInd>
										</xsl:if>
										<xsl:if
											test="./instanceData/TXLife/A_SolicitedToSellInd_PINS != '1'">
											<SolicitedToSellInd tc="0">False
											</SolicitedToSellInd>
										</xsl:if>
										<xsl:if test="./instanceData/TXLife/A_ForeignTravelInd_PINS = '1'">
											<WrkOutsideUSOrCanadaLast2YrsInd
												tc="1">True</WrkOutsideUSOrCanadaLast2YrsInd>
										</xsl:if>
										<xsl:if test="./instanceData/TXLife/A_ForeignTravelInd_PINS = '0'">
											<WrkOutsideUSOrCanadaLast2YrsInd
												tc="0">False</WrkOutsideUSOrCanadaLast2YrsInd>
										</xsl:if>
										<xsl:if
											test="string-length(./instanceData/TXLife/A_WorkItemID) >  0">
											<xsl:choose>
												<xsl:when test="contains(instanceData/TXLife/A_WorkItemID ,':')">
													<WorkitemID>
														<xsl:value-of
															select="translate(instanceData/TXLife/A_WorkItemID,':','.')" />
													</WorkitemID>
												</xsl:when>
												<xsl:when
													test="not(contains(instanceData/TXLife/A_WorkItemID ,':'))">
													<WorkitemID>
														<xsl:value-of select="instanceData/TXLife/A_WorkItemID" />
													</WorkitemID>
												</xsl:when>
											</xsl:choose>
										</xsl:if>
										<xsl:if test="./instanceData/TXLife/A_FutureChildBeneInd = '1'">
											<FutureChildInd tc="1">True</FutureChildInd>
										</xsl:if>
										<xsl:if test="./instanceData/TXLife/A_FutureChildBeneInd = '0'">
											<FutureChildInd tc="0">False</FutureChildInd>
										</xsl:if>
										<xsl:if test="./instanceData/TXLife/A_BeneMatchInd = '1'">
											<BeneficiariesMatchInd tc="1">True
											</BeneficiariesMatchInd>
										</xsl:if>
										<xsl:if test="./instanceData/TXLife/A_BeneMatchInd = '0'">
											<BeneficiariesMatchInd tc="0">False
											</BeneficiariesMatchInd>
										</xsl:if>
										<xsl:if test="./instanceData/TXLife/A_TIASignatureOK = '1'">
											<TIASignedInd tc="1">True</TIASignedInd>
										</xsl:if>
										<xsl:if test="./instanceData/TXLife/A_TIASignatureOK = '0'">
											<TIASignedInd tc="0">False</TIASignedInd>
										</xsl:if>
										<!--BHFD-390 START -->
										<xsl:if
											test="./instanceData/TXLife/A_ThirdPartyPayorSignatureOK = '1'">
											<AppSignedByThirdPartyInd tc="1">True
											</AppSignedByThirdPartyInd>
										</xsl:if>
										<xsl:if
											test="./instanceData/TXLife/A_ThirdPartyPayorSignatureOK = '0'">
											<AppSignedByThirdPartyInd tc="0">False
											</AppSignedByThirdPartyInd>
										</xsl:if>
										<!--BHFD-390 END -->
										<xsl:if
											test="string-length(instanceData/TXLife/A_RecieptDate_TIA)>0">
											<TIAReceiptDate>
												<xsl:call-template name="FormatDate">
													<xsl:with-param name="Separator">
														/
													</xsl:with-param>
													<xsl:with-param name="DateString">
														<xsl:value-of select="instanceData/TXLife/A_RecieptDate_TIA" />
													</xsl:with-param>
												</xsl:call-template>
											</TIAReceiptDate>
										</xsl:if>
										<FATCA>
											<xsl:value-of select="instanceData/TXLife/A_FATCACode" />
										</FATCA>
										<xsl:if test="string-length(instanceData/TXLife/A_CaseID)>0">
											<CaseID>
												<xsl:value-of select="instanceData/TXLife/A_CaseID" />
											</CaseID>
										</xsl:if>
										<xsl:if test="string-length(instanceData/TXLife/A_CustomerID)>0">
											<CustomerID>
												<xsl:value-of select="instanceData/TXLife/A_CustomerID" />
											</CustomerID>
										</xsl:if>
										<!--BHFD-1147 -->
										<xsl:if test="./instanceData/TXLife/A_NotToCompleteInd = '1'">
											<ChooseNotToCompleteInd tc="1">True</ChooseNotToCompleteInd>
										</xsl:if>
										<xsl:if test="./instanceData/TXLife/A_FinRepAdvisementInd = '1'">
											<FinRepAdvisementInd tc="1">True</FinRepAdvisementInd>
										</xsl:if>
									</ApplicationInfoExtension>
								</OLifEExtension>
							</ApplicationInfo>
							<OLifEExtension ExtensionCode="Policy 2.8.90"
								VendorCode="05">
								<PolicyExtension>
									<xsl:if test="./instanceData/TXLife/A_EDElected = '1'">
										<!-- Updated By Puja -->
										<AuthElectDocDeliveryInd tc="0">False
										</AuthElectDocDeliveryInd>
									</xsl:if>
									<xsl:if test="./instanceData/TXLife/A_EDElected = '0'">
										<AuthElectDocDeliveryInd tc="1">True
										</AuthElectDocDeliveryInd>
										<!-- Updated By Puja -->
									</xsl:if>
									<xsl:if test="./instanceData/TXLife/A_LTDPayOption != '-1'">
										<NLGPeriod>
											<xsl:attribute name="tc">
												<xsl:value-of select="instanceData/TXLife/A_LTDPayOption" />
											</xsl:attribute>
											<xsl:value-of select="instanceData/TXLife/A_LTDPayOption_Desc" />
										</NLGPeriod>
									</xsl:if>
									<xsl:if
										test="string-length(instanceData/TXLife/A_PlannedFirstYrLump)>0">
										<xsl:choose>
											<xsl:when
												test="contains(instanceData/TXLife/A_PlannedFirstYrLump ,'$')">
												<PlannedFirstYrLump>
													<xsl:value-of
														select="translate(substring-after(instanceData/TXLife/A_PlannedFirstYrLump, '$'),',','')" />
												</PlannedFirstYrLump>
											</xsl:when>
											<xsl:when
												test="not(contains(instanceData/TXLife/A_PlannedFirstYrLump ,'$'))">
												<PlannedFirstYrLump>
													<xsl:value-of
														select="translate(instanceData/TXLife/A_PlannedFirstYrLump,',','')" />
												</PlannedFirstYrLump>
											</xsl:when>
										</xsl:choose>
									</xsl:if>
									<xsl:if
										test="string-length(instanceData/TXLife/A_PlannedYearlyPrem)>0">
										<xsl:choose>
											<xsl:when
												test="contains(instanceData/TXLife/A_PlannedYearlyPrem ,'$')">
												<PlannedYearlyPrem>
													<xsl:value-of
														select="translate(substring-after(instanceData/TXLife/A_PlannedYearlyPrem, '$'),',','')" />
												</PlannedYearlyPrem>
											</xsl:when>
											<xsl:when
												test="not(contains(instanceData/TXLife/A_PlannedYearlyPrem ,'$'))">
												<PlannedYearlyPrem>
													<xsl:value-of
														select="translate(instanceData/TXLife/A_PlannedYearlyPrem,',','')" />
												</PlannedYearlyPrem>
											</xsl:when>
										</xsl:choose>
									</xsl:if>
									<xsl:if
										test="./instanceData/TXLife/A_ElectACVR = '1' and ./instanceData/TXLife/A_DeclineACVR != '1'">
										<RebalancingInd tc="1">True</RebalancingInd>
									</xsl:if>
									<xsl:if test="./instanceData/TXLife/A_DeclineACVR = '1'">
										<RebalancingInd tc="0">False</RebalancingInd>
									</xsl:if>
								</PolicyExtension>
							</OLifEExtension>
						</Policy>
						<Investment>
							<xsl:for-each select="instanceData/TXLife/*">
								<xsl:if test="starts-with(name(),'A_AllocPercent_')">
									<xsl:if test="string-length(.) > 0">
										<xsl:variable name="pos" select="substring(name(),16)" />
										<xsl:variable name="posValue" select='format-number($pos, "0")' />
										<xsl:if test="../*[name()=concat('A_AllocPercent_',$pos)]!='0'">
											<SubAccount>
												<xsl:attribute name="id">
													<xsl:value-of select="concat('SubAccount_',$pos)" />
												</xsl:attribute>
												<ProductCode>
													<xsl:value-of select="$pos" />
												</ProductCode>
											</SubAccount>
										</xsl:if>
									</xsl:if>
								</xsl:if>
							</xsl:for-each>
							<!-- for automatic cash value rebalancing -->
							<!-- <xsl:for-each select="instanceData/TXLife/*"> <xsl:if test="starts-with(name(),'A_AllocPercentDCA_')"> 
								<xsl:if test="string-length(.) > 0"> <xsl:variable name="pos" select="substring(name(),19)" 
								/> <xsl:variable name="posValue" select='format-number($pos, "0")' /> <xsl:if 
								test="../*[name()=concat('A_AllocPercentDCA_',$pos)]!='0'"> <SubAccount> 
								<xsl:attribute name="id"> <xsl:value-of select="concat('SubAccountDCA_',$pos)" 
								/> </xsl:attribute> <ProductCode> <xsl:value-of select="$pos" /> </ProductCode> 
								</SubAccount> </xsl:if> </xsl:if> </xsl:if> </xsl:for-each> -->
							<!-- <xsl:if test="(not(string-length(./instanceData/TXLife/A_AllocPercent_30)>0) 
								or ./instanceData/TXLife/A_AllocPercent_30 = '0') and string-length(./instanceData/TXLife/A_DollarsFromFixedAccount)>0"> 
								<SubAccount> <xsl:attribute name="id">SubAccount_30</xsl:attribute> <ProductCode>30</ProductCode> 
								</SubAccount> </xsl:if> -->
						</Investment>
						<Arrangement id="Arrangment_1">
							<ArrType tc="37">Standing Allocation</ArrType>
							<xsl:for-each select="instanceData/TXLife/*">
								<xsl:if test="starts-with(name(),'A_AllocPercent_')">
									<xsl:if test="string-length(.) > 0">
										<xsl:variable name="pos" select="substring(name(),16)" />
										<xsl:variable name="posValue" select='format-number($pos, "0")' />
										<xsl:if test="../*[name()=concat('A_AllocPercent_',$pos)]!='0'">
											<ArrDestination>
												<xsl:attribute name="id">
													<xsl:value-of select="concat('ArrDestination_',$pos)" />
												</xsl:attribute>
												<xsl:attribute name="SubAcctID">
													<xsl:value-of select="concat('SubAccount_',$pos)" />
												</xsl:attribute>
												<TransferAmtType tc="3">Percent
												</TransferAmtType>
												<TransferPct>
													<xsl:value-of select="../*[name()=concat('A_AllocPercent_',$pos)]" />
												</TransferPct>
											</ArrDestination>
										</xsl:if>
									</xsl:if>
								</xsl:if>
							</xsl:for-each>
						</Arrangement>
						<xsl:if test="./instanceData/TXLife/A_EFT_MPREM= '7'">
							<Banking id="Banking_1">
								<BankAcctType>
									<xsl:attribute name="tc">
										<xsl:value-of select="instanceData/TXLife/A_AccountType" />
									</xsl:attribute>
									<xsl:value-of select="instanceData/TXLife/A_AccountType_Desc" />
								</BankAcctType>
								<AccountNumber>
									<xsl:value-of select="instanceData/TXLife/A_AccountNo" />
								</AccountNumber>
								<RoutingNum>
									<xsl:value-of select="instanceData/TXLife/A_RoutingNo" />
								</RoutingNum>
								<OLifEExtension VendorCode="05" ExtensionCode="Banking 2.8.90">
									<BankingExtension>
										<xsl:if test="./instanceData/TXLife/A_PremPayor != '-1'">
											<AccountHolderNameCC>
												<xsl:if test="./instanceData/TXLife/A_PremPayor != '-1'">
													<xsl:if test="./instanceData/TXLife/A_PremPayor = '2'">
														<AccountHolderName>
															<xsl:value-of select="instanceData/TXLife/A_EntityName_OWN1" />
															<xsl:if
																test="./instanceData/TXLife/A_Prefix_OWN1 != '-1' or string-length(instanceData/TXLife/A_FirstName_OWN1)>0 or string-length(instanceData/TXLife/A_MiddleName_OWN1)>0 or string-length(instanceData/TXLife/A_LastName_OWN1)>0 or ./instanceData/TXLife/A_Suffix_OWN1 != '-1'">
																<xsl:value-of
																	select="concat(instanceData/TXLife/A_Prefix_OWN1_Desc,' ',instanceData/TXLife/A_FirstName_OWN1,' ',instanceData/TXLife/A_MiddleName_OWN1,' ',instanceData/TXLife/A_LastName_OWN1,' ',instanceData/TXLife/A_Suffix_OWN1_Desc)" />
															</xsl:if>
														</AccountHolderName>
													</xsl:if>
													<xsl:if test="./instanceData/TXLife/A_PremPayor = '3'">
														<AccountHolderName>
															<xsl:value-of select="instanceData/TXLife/A_EntityName_PYR" />
															<xsl:if
																test="./instanceData/TXLife/A_Prefix_PYR != '-1' or string-length(instanceData/TXLife/A_FirstName_PYR)>0 or string-length(instanceData/TXLife/A_MiddleName_PYR)>0 or string-length(instanceData/TXLife/A_LastName_PYR)>0 or ./instanceData/TXLife/A_Suffix_PYR != '-1'">
																<xsl:value-of
																	select="concat(instanceData/TXLife/A_Prefix_PYR_Desc,' ',instanceData/TXLife/A_FirstName_PYR,' ',instanceData/TXLife/A_MiddleName_PYR,' ',instanceData/TXLife/A_LastName_PYR,' ',instanceData/TXLife/A_Suffix_PYR_Desc)" />
															</xsl:if>
														</AccountHolderName>
													</xsl:if>
													<xsl:if test="./instanceData/TXLife/A_PremPayor = '1'">
														<AccountHolderName>
															<xsl:value-of select="instanceData/TXLife/A_EntityName_PINS" />
															<xsl:if
																test="./instanceData/TXLife/A_Prefix_PINS != '-1' or string-length(instanceData/TXLife/A_FirstName_PINS)>0 or string-length(instanceData/TXLife/A_MiddleName_PINS)>0 or string-length(instanceData/TXLife/A_LastName_PINS)>0 or ./instanceData/TXLife/A_Suffix_PINS != '-1'">
																<xsl:value-of
																	select="concat(instanceData/TXLife/A_Prefix_PINS_Desc,' ',instanceData/TXLife/A_FirstName_PINS,' ',instanceData/TXLife/A_MiddleName_PINS,' ',instanceData/TXLife/A_LastName_PINS,' ',instanceData/TXLife/A_Suffix_PINS_Desc)" />
															</xsl:if>
														</AccountHolderName>
													</xsl:if>
												</xsl:if>
											</AccountHolderNameCC>
										</xsl:if>
										<BankBranchName>
											<xsl:value-of select="instanceData/TXLife/A_BranchName" />
										</BankBranchName>
										<BankName>
											<xsl:value-of select="instanceData/TXLife/A_BankName" />
										</BankName>
										<xsl:if test="./instanceData/TXLife/A_PremPayor = '3'">
											<xsl:if test="./instanceData/TXLife/A_RelToPI_PYR!='-1'">
												<AccountHolderRelation>
													<xsl:attribute name="tc">
														<xsl:value-of select="instanceData/TXLife/A_RelToPI_PYR" />
													</xsl:attribute>
													<xsl:value-of select="instanceData/TXLife/A_RelToPI_PYR_Desc" />
												</AccountHolderRelation>
											</xsl:if>
										</xsl:if>
									</BankingExtension>
								</OLifEExtension>
							</Banking>
						</xsl:if>
					</Holding>
					<!-- NB Holding END -->
					<!-- Replacment Holding START -->
					<xsl:if test="./instanceData/TXLife/A_InforceNAppliedfor_PINS='1'">
						<xsl:for-each select="instanceData/TXLife/*">
							<xsl:if test="starts-with(name(),'A_InsuranceAmount_REP')">
								<xsl:variable name="pos" select="substring(name(),22)" />
								<xsl:variable name="repCount"
									select='format-number(../*[name()="A_COUNT_TOTAL_REP"], 	"0")' />
								<xsl:variable name="posValue" select='format-number($pos, "0")' />
								<xsl:if test="$pos != '' and $posValue &lt;= $repCount">
									<xsl:if
										test="string-length(../*[name()=concat('A_ReplacementCompany_REP',$pos)])>0 and
											../*[name()=concat('A_ReplacementCompany_REP',$pos)]!='-1'">
										<Holding>
											<xsl:attribute name="id">
													<xsl:value-of select="concat('Holding_REP_',$pos)" />
												</xsl:attribute>
											<HoldingTypeCode tc="2">Policy</HoldingTypeCode>
											<HoldingStatus tc="1">Active</HoldingStatus>
											<Policy>
												<xsl:if
													test="string-length(../*[name()=concat('A_PolNum_REP',$pos)])>0">
													<PolNumber>
														<xsl:value-of select="../*[name()=concat('A_PolNum_REP',$pos)]" />
													</PolNumber>
												</xsl:if>
												<!-- BHFD-1171 -->
												<xsl:if
													test="string-length(../*[name()=concat('A_PlanType_REP',$pos,'_Desc')])>0">
													<ProductCode>
														<xsl:value-of
															select="../*[name()=concat('A_PlanType_REP',$pos, '_Desc')]" />
													</ProductCode>
												</xsl:if>
												<xsl:if
													test="../*[name()=concat('A_ReplacementInd_REP',$pos)] = '1'">
													<xsl:choose>
														<xsl:when
															test="contains(../*[name()=concat('A_ReplacementCompany_REP',$pos,'_Desc')] ,'BrightHouse') or
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
												</xsl:if>
												<xsl:if
													test="../*[name()=concat('A_ReplacementInd_REP',$pos)] = '0'">
													<ReplacementType tc="1">None</ReplacementType>
												</xsl:if>
												<xsl:if
													test="string-length(../*[name()=concat('A_IssueYear_REP',$pos)])>0">
													<IssueDate>
														<xsl:value-of
															select="concat(../*[name()=concat('A_IssueYear_REP',$pos)],'-01-01')" />
													</IssueDate>
												</xsl:if>
												<Life>
													<Coverage>
														<xsl:attribute name="id">
																<xsl:value-of select="concat('Coverage_RPL_',$pos)" />
															</xsl:attribute>
														<xsl:choose>
															<xsl:when
																test="contains(../*[name()=concat('A_InsuranceAmount_REP',$pos)] ,'$')">
																<CurrentAmt>
																	<xsl:value-of
																		select="translate(substring-after(../*[name()=concat('A_InsuranceAmount_REP',$pos)], '$'),',','')" />
																</CurrentAmt>
															</xsl:when>
															<xsl:when
																test="not(contains(../*[name()=concat('A_InsuranceAmount_REP',$pos)] ,'$'))">
																<CurrentAmt>
																	<xsl:value-of
																		select="translate(../*[name()=concat('A_InsuranceAmount_REP',$pos)],',','')" />
																</CurrentAmt>
															</xsl:when>
														</xsl:choose>
													</Coverage>
													<!-- BHFD-1169 -->
													<LifeUSA>
														<xsl:if
															test="../*[name()=concat('A_1035ExchgInd_REP',$pos)] = '1'">
															<Internal1035 tc="1">True</Internal1035>
														</xsl:if>
														<xsl:if
															test="../*[name()=concat('A_1035ExchgInd_REP',$pos)] != '1'">
															<Internal1035 tc="0">False</Internal1035>
														</xsl:if>
													</LifeUSA>
												</Life>
												<ApplicationInfo>
													<xsl:if
														test="../*[name()=concat('A_ReplacementInd_REP',$pos)] = '0'">
														<ReplacementInd tc="0">false</ReplacementInd>
													</xsl:if>
													<xsl:if
														test="../*[name()=concat('A_ReplacementInd_REP',$pos)] = '1'">
														<ReplacementInd tc="1">true</ReplacementInd>
													</xsl:if>
												</ApplicationInfo>
											</Policy>
											<OLifEExtension ExtensionCode="Policy 2.8.90"
												VendorCode="05">
												<PolicyExtension>
													<ReplacementStatus>
														<xsl:if
															test="../*[name()=concat('A_PolicyStatus_REP',$pos)] != '-1'">
															<xsl:attribute name="tc">
																	<xsl:value-of
																select="../*[name()=concat('A_PolicyStatus_REP',$pos)]" />
																</xsl:attribute>
															<xsl:value-of
																select="../*[name()=concat('A_PolicyStatus_REP',$pos,'_Desc')]" />
														</xsl:if>
													</ReplacementStatus>
												</PolicyExtension>
											</OLifEExtension>
										</Holding>
									</xsl:if>
									<xsl:if
										test="string-length(../*[name()=concat('A_ReplacementCompany_REP',$pos)])>0">
										<Party>
											<xsl:attribute name="id">
												<xsl:value-of select="concat('Party_REP',$pos,'_CAR')" />
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
									<xsl:if
										test="string-length(../*[name()=concat('A_LastName_REP',$pos)])>0 or string-length(../*[name()=concat('A_FirstName_REP',$pos)])>0 ">
										<Party>
											<xsl:attribute name="id">
													<xsl:value-of select="concat('Party_REP',$pos,'_INS')" />
												</xsl:attribute>
											<PartyTypeCode tc="1">Person</PartyTypeCode>
											<Person>
												<FirstName>
													<xsl:value-of select="../*[name()=concat('A_FirstName_REP',$pos)]" />
												</FirstName>
												<MiddleName>
													<xsl:value-of
														select="../*[name()=concat('A_MiddleName_REP',$pos)]" />
												</MiddleName>
												<LastName>
													<xsl:value-of select="../*[name()=concat('A_LastName_REP',$pos)]" />
												</LastName>
												<xsl:if test="../*[name()=concat('A_Prefix_REP',$pos)] != '-1'">
													<Prefix>
														<xsl:value-of select="../*[name()=concat('A_Prefix_REP',$pos)]" />
													</Prefix>
												</xsl:if>
												<xsl:if test="../*[name()=concat('A_Suffix_REP',$pos)] != '-1'">
													<Suffix>
														<xsl:value-of select="../*[name()=concat('A_Suffix_REP',$pos)]" />
													</Suffix>
												</xsl:if>
											</Person>
										</Party>
									</xsl:if>
								</xsl:if>
							</xsl:if>
						</xsl:for-each>
					</xsl:if>
					<!-- Replacment Holding END -->
					<!-- PINS Party START -->
					<xsl:if test="string-length(./instanceData/TXLife/A_FirstName_PINS)>0">
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
							<xsl:if
								test="string-length(./instanceData/TXLife/A_GovtID_TID_PINS)>0">
								<GovtID>
									<xsl:value-of
										select="translate(./instanceData/TXLife/A_GovtID_TID_PINS,'-','')" />
								</GovtID>
								<GovtIDTC tc="2">Taxpayer Identification Number</GovtIDTC>
							</xsl:if>
							<xsl:if
								test="string-length(./instanceData/TXLife/A_EstNetWorth_PINS) >  0">
								<xsl:choose>
									<xsl:when
										test="contains(instanceData/TXLife/A_EstNetWorth_PINS ,'$')">
										<EstNetWorth>
											<xsl:value-of
												select="translate(substring-after(instanceData/TXLife/A_EstNetWorth_PINS, '$'),',','')" />
										</EstNetWorth>
									</xsl:when>
									<xsl:when
										test="not(contains(instanceData/TXLife/A_EstNetWorth_PINS ,'$'))">
										<EstNetWorth>
											<xsl:value-of
												select="translate(instanceData/TXLife/A_EstNetWorth_PINS,',','')" />
										</EstNetWorth>
									</xsl:when>
								</xsl:choose>
							</xsl:if>
							<Person>
								<FirstName>
									<xsl:value-of select="instanceData/TXLife/A_FirstName_PINS" />
								</FirstName>
								<xsl:if
									test="string-length(./instanceData/TXLife/A_MiddleName_PINS)>0">
									<MiddleName>
										<xsl:value-of select="instanceData/TXLife/A_MiddleName_PINS" />
									</MiddleName>
								</xsl:if>
								<LastName>
									<xsl:value-of select="instanceData/TXLife/A_LastName_PINS" />
								</LastName>
								<xsl:if test="./instanceData/TXLife/A_Prefix_PINS != '-1'">
									<Prefix>
										<xsl:value-of select="instanceData/TXLife/A_Prefix_PINS" />
									</Prefix>
								</xsl:if>
								<xsl:if test="./instanceData/TXLife/A_Suffix_PINS != '-1'">
									<Suffix>
										<xsl:value-of select="instanceData/TXLife/A_Suffix_PINS" />
									</Suffix>
								</xsl:if>
								<xsl:if test="./instanceData/TXLife/A_Occupation_PINS != '-1'">
									<Occupation>
										<xsl:value-of select="instanceData/TXLife/A_Occupation_PINS" />
									</Occupation>
								</xsl:if>
								<Gender>
									<xsl:attribute name="tc">
										<xsl:value-of select="instanceData/TXLife/A_Gender_PINS" />
									</xsl:attribute>
									<xsl:value-of select="instanceData/TXLife/A_Gender_PINS_Desc" />
								</Gender>
								<BirthDate>
									<xsl:value-of select="instanceData/TXLife/A_DOB_PINS" />
								</BirthDate>
								<xsl:if test="./instanceData/TXLife/A_IDType_PINS = '17'">
									<PassportNo>
										<xsl:value-of select="instanceData/TXLife/A_IDNum_PINS" />
									</PassportNo>
								</xsl:if>
								<xsl:if test="./instanceData/TXLife/A_Citizenship_PINS != '-1'">
									<Citizenship>
										<xsl:attribute name="tc">
											<xsl:value-of select="instanceData/TXLife/A_Citizenship_PINS" />
										</xsl:attribute>
										<xsl:value-of select="instanceData/TXLife/A_Citizenship_PINS_Desc" />
									</Citizenship>
								</xsl:if>
								<xsl:if test="./instanceData/TXLife/A_USCitizenInd_PINS = '1'">
									<Citizenship tc="1">United States of America
									</Citizenship>
								</xsl:if>
								<xsl:if test="string-length(./instanceData/TXLife/A_EstSalary) >  0">
									<xsl:choose>
										<xsl:when test="contains(instanceData/TXLife/A_EstSalary ,'$')">
											<EstSalary>
												<xsl:value-of
													select="translate(substring-after(instanceData/TXLife/A_EstSalary, '$'),',','')" />
											</EstSalary>
										</xsl:when>
										<xsl:when
											test="not(contains(instanceData/TXLife/A_EstSalary ,'$'))">
											<EstSalary>
												<xsl:value-of
													select="translate(instanceData/TXLife/A_EstSalary,',','')" />
											</EstSalary>
										</xsl:when>
									</xsl:choose>
								</xsl:if>
								<xsl:if test="./instanceData/TXLife/A_IDType_PINS = '29'">
									<DriversLicenseNum>
										<xsl:value-of select="instanceData/TXLife/A_IDNum_PINS" />
									</DriversLicenseNum>
								</xsl:if>
								<xsl:if
									test="./instanceData/TXLife/A_IDType_PINS = '29' and string-length(./instanceData/TXLife/A_IDNum_PINS)>0">
									<DriversLicenseState>
										<xsl:attribute name="tc">
											<xsl:value-of select="instanceData/TXLife/A_IssuerIDState_PINS" />
										</xsl:attribute>
										<xsl:value-of select="instanceData/TXLife/A_IssuerIDState_PINS_Desc" />
									</DriversLicenseState>
								</xsl:if>
								<xsl:if test="./instanceData/TXLife/A_BirthCountryTC_PINS != '-1'">
									<BirthCountry>
										<xsl:attribute name="tc">
											<xsl:value-of select="instanceData/TXLife/A_BirthCountryTC_PINS" />
										</xsl:attribute>
										<xsl:value-of select="instanceData/TXLife/A_BirthCountryTC_PINS_Desc" />
									</BirthCountry>
								</xsl:if>
								<xsl:if test="./instanceData/TXLife/A_BirthCountryTC_PINS = 'other'">
									<BirthCountry>
										<xsl:attribute name="tc">
											<xsl:value-of select="instanceData/TXLife/A_BirthCountryTC_PINS" />
										</xsl:attribute>
										<xsl:value-of select="instanceData/TXLife/A_BirthCountryTC_PINS_Desc" />
									</BirthCountry>
								</xsl:if>
								<xsl:if
									test="./instanceData/TXLife/A_BirthJurisdictionTC_PINS != '-1'">
									<BirthJurisdictionTC>
										<xsl:attribute name="tc">
											<xsl:value-of
											select="instanceData/TXLife/A_BirthJurisdictionTC_PINS" />
										</xsl:attribute>
										<xsl:value-of
											select="instanceData/TXLife/A_BirthJurisdictionTC_PINS_Desc" />
									</BirthJurisdictionTC>
								</xsl:if>
								<OLifEExtension VendorCode="05" ExtensionCode="Person 2.8.90">
									<PersonExtension>
										<xsl:if test="(./instanceData/TXLife/A_TobaccoInd_PINS) = '0'">
											<RateClassAppliedFor>1</RateClassAppliedFor>
										</xsl:if>
										<xsl:if test="(./instanceData/TXLife/A_TobaccoInd_PINS) = '1'">
											<RateClassAppliedFor>1009900004</RateClassAppliedFor>
										</xsl:if>
										<xsl:if test="./instanceData/TXLife/A_Citizenship_PINS != '1'">
											<xsl:if test="./instanceData/TXLife/A_VisaType_PINS != '-1'">
												<VisaType>
													<xsl:attribute name="tc">
														<xsl:value-of select="instanceData/TXLife/A_VisaType_PINS" />
													</xsl:attribute>
													<xsl:value-of select="instanceData/TXLife/A_VisaType_PINS_Desc" />
												</VisaType>
												<xsl:if
													test="string-length(./instanceData/TXLife/A_VisaNumber_PINS)>0">
													<VisaNumber>
														<xsl:value-of select="instanceData/TXLife/A_VisaNumber_PINS" />
													</VisaNumber>
												</xsl:if>
											</xsl:if>
											<!-- BHFD-1183 -->
											<xsl:if
												test="string-length(./instanceData/TXLife/A_YearsinUS_PINS)	>  0">
												<NumOfYearsInUS>
													<xsl:value-of select="instanceData/TXLife/A_YearsinUS_PINS" />
												</NumOfYearsInUS>
											</xsl:if>
											<xsl:if
												test="./instanceData/TXLife/A_ResidencyCountry_PINS != '-1'">
												<PermCountry>
													<xsl:attribute name="tc">
														<xsl:value-of
														select="instanceData/TXLife/A_ResidencyCountry_PINS" />
													</xsl:attribute>
													<xsl:value-of
														select="instanceData/TXLife/A_ResidencyCountry_PINS_Desc" />
												</PermCountry>
											</xsl:if>
										</xsl:if>
										<xsl:if test="(./instanceData/TXLife/A_ValidUSDL_PINS) = '1'">
											<ValidDLInd tc="1">true</ValidDLInd>
										</xsl:if>
										<xsl:if test="(./instanceData/TXLife/A_ValidUSDL_PINS) = '0'">
											<ValidDLInd tc="0">false</ValidDLInd>
										</xsl:if>
										<!-- BHFD-1184 -->
										<xsl:if test="(./instanceData/TXLife/A_NonUSIDType_PINS ) = '2'">
											<VisaExpDate>
												<xsl:call-template name="FormatDate">
													<xsl:with-param name="Separator">
														/
													</xsl:with-param>
													<xsl:with-param name="DateString">
														<xsl:value-of select="instanceData/TXLife/A_NonUSIDExpDate_PINS" />
													</xsl:with-param>
												</xsl:call-template>
											</VisaExpDate>
										</xsl:if>
										<xsl:if
											test="string-length(./instanceData/TXLife/A_IDType_PINS)>0 and (./instanceData/TXLife/A_IDType_PINS != '29') and (./instanceData/TXLife/A_IDType_PINS != '-1')">
											<xsl:if test="./instanceData/TXLife/A_IDType_PINS != '29'">
												<GovtIDInfo id="GovtIDInfo_PINS1">
													<GovtID>
														<xsl:value-of select="instanceData/TXLife/A_IDNum_PINS" />
													</GovtID>
													<!-- Modified by Puja, BHFD-1112 Start -->
													<ExpDate>
														<xsl:call-template name="FormatDate">
															<xsl:with-param name="Separator">
																/
															</xsl:with-param>
															<xsl:with-param name="DateString">
																<xsl:value-of
																	select="instanceData/TXLife/A_IDExpirationDate_PINS" />
															</xsl:with-param>
														</xsl:call-template>
													</ExpDate>
													<IssueDate>
														<xsl:call-template name="FormatDate">
															<xsl:with-param name="Separator">
																/
															</xsl:with-param>
															<xsl:with-param name="DateString">
																<xsl:value-of select="instanceData/TXLife/A_IDIssueDate_PINS" />
															</xsl:with-param>
														</xsl:call-template>
													</IssueDate>
													<!-- Modified by Puja, BHFD-1112 End -->
													<GovtIDTC>
														<xsl:attribute name="tc">
															<xsl:value-of select="instanceData/TXLife/A_IDType_PINS" />
														</xsl:attribute>
														<xsl:value-of select="instanceData/TXLife/A_IDType_PINS_Desc" />
													</GovtIDTC>
													<xsl:if
														test="string-length(./instanceData/TXLife/A_IssuerIDCountry_PINS)	>  0">
														<Nation>
															<xsl:attribute name="tc">
																<xsl:value-of
																select="instanceData/TXLife/A_IssuerIDCountry_PINS" />
															</xsl:attribute>
															<xsl:value-of
																select="instanceData/TXLife/A_IssuerIDCountry_PINS_Desc" />
														</Nation>
													</xsl:if>
													<xsl:if
														test="./instanceData/TXLife/A_IssuerIDState_PINS != '-1'">
														<Jurisdiction>
															<xsl:attribute name="tc">
																<xsl:value-of
																select="instanceData/TXLife/A_IssuerIDState_PINS" />
															</xsl:attribute>
															<xsl:value-of
																select="instanceData/TXLife/A_IssuerIDState_PINS_Desc" />
														</Jurisdiction>
													</xsl:if>
													<!-- BHFD-1112 changed the TAG and moved the position above -->
													<!-- <GovtIDIssDate> <xsl:call-template name="FormatDate"> <xsl:with-param 
														name="Separator"> / </xsl:with-param> <xsl:with-param name="DateString"> 
														<xsl:value-of select="instanceData/TXLife/A_IDIssueDate_PINS" /> </xsl:with-param> 
														</xsl:call-template> </GovtIDIssDate> <GovtIDExpDate> <xsl:call-template 
														name="FormatDate"> <xsl:with-param name="Separator"> / </xsl:with-param> 
														<xsl:with-param name="DateString"> <xsl:value-of select="instanceData/TXLife/A_IDExpiratnDate_PINS" 
														/> </xsl:with-param> </xsl:call-template> </GovtIDExpDate> -->
												</GovtIDInfo>
											</xsl:if>
										</xsl:if>
										<!--BHFD-1184 for GreenCard for Non-US Citizen Starts -->
										<xsl:if test="(./instanceData/TXLife/A_NonUSIDType_PINS ) = '1'">
											<GovtIDInfo id="GovtIDInfo_PINS2">
												<GovtID>
													<xsl:value-of select="instanceData/TXLife/A_VisaNumber_PINS" />
												</GovtID>
												<ExpDate>
													<xsl:call-template name="FormatDate">
														<xsl:with-param name="Separator">
															/
														</xsl:with-param>
														<xsl:with-param name="DateString">
															<xsl:value-of select="instanceData/TXLife/A_NonUSIDExpDate_PINS" />
														</xsl:with-param>
													</xsl:call-template>
												</ExpDate>
												<GovtIDTC tc="18">Green Card</GovtIDTC>
												<xsl:if
													test="../instanceData/TXLife/A_ResidencyCountry_PINS != '-1'">
													<Nation>
														<xsl:attribute name="tc">
																<xsl:value-of
															select="instanceData/TXLife/A_ResidencyCountry_PINS" />
															</xsl:attribute>
														<xsl:value-of
															select="instanceData/TXLife/A_ResidencyCountry_PINS_Desc" />
													</Nation>
												</xsl:if>
											</GovtIDInfo>
										</xsl:if>
										<!--BHFD-1184 for GreenCard for Non-US Citizen Ends -->
									</PersonExtension>
								</OLifEExtension>
							</Person>
							<Address id="Address_PINS">
								<AddressTypeCode tc="1">Home</AddressTypeCode>
								<AttentionLine>
									<xsl:value-of select="instanceData/TXLife/A_AddressLine1_PINS" />
								</AttentionLine>
								<Line1>
									<xsl:value-of select="instanceData/TXLife/A_AddressLine2_PINS" />
								</Line1>
								<xsl:if
									test="string-length(./instanceData/TXLife/A_AddressLine3_PINS) > 0">
									<Line2>
										<xsl:value-of select="instanceData/TXLife/A_AddressLine3_PINS" />
									</Line2>
								</xsl:if>
								<xsl:if
									test="string-length(./instanceData/TXLife/A_AddressLine4_PINS) > 0">
									<Line3>
										<xsl:value-of select="instanceData/TXLife/A_AddressLine4_PINS" />
									</Line3>
								</xsl:if>
								<City>
									<xsl:value-of select="instanceData/TXLife/A_City_PINS" />
								</City>
								<AddressStateTC>
									<xsl:attribute name="tc">
										<xsl:value-of select="instanceData/TXLife/A_State_PINS" />
									</xsl:attribute>
									<xsl:value-of select="instanceData/TXLife/A_State_PINS_Desc" />
								</AddressStateTC>
								<xsl:choose>
									<xsl:when test="contains(instanceData/TXLife/A_ZipCode_PINS ,'-')">
										<Zip>
											<xsl:value-of
												select="translate(instanceData/TXLife/A_ZipCode_PINS,'-','')" />
										</Zip>
									</xsl:when>
									<xsl:when
										test="not(contains(instanceData/TXLife/A_ZipCode_PINS ,'-'))">
										<Zip>
											<xsl:value-of select="instanceData/TXLife/A_ZipCode_PINS" />
										</Zip>
									</xsl:when>
								</xsl:choose>
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
								<EMailAddress id="EMailAddress1_PINS">
									<EMailType tc="2">Personal</EMailType>
									<AddrLine>
										<xsl:value-of select="instanceData/TXLife/A_EmailAddress_PINS" />
									</AddrLine>
								</EMailAddress>
							</xsl:if>
							<xsl:if
								test="string-length(./instanceData/TXLife/A_EmailAddress_PINS)> 0 and ./instanceData/TXLife/A_EDElected = '0'">
								<EMailAddress id="EMailAddress2_PINS">
									<EMailType tc="1000500001">eDelivery</EMailType>
									<AddrLine>
										<xsl:value-of select="instanceData/TXLife/A_EmailAddress_PINS" />
									</AddrLine>
								</EMailAddress>
							</xsl:if>
							<Risk>
								<!-- BHFD-1225 -->
								<xsl:if test="./instanceData/TXLife/A_InforceNAppliedfor_PINS = '1'">
									<ExistingInsuranceInd tc="1">True</ExistingInsuranceInd>
								</xsl:if>
								<xsl:if test="./instanceData/TXLife/A_InforceNAppliedfor_PINS != '1'">
									<ExistingInsuranceInd tc="0">False</ExistingInsuranceInd>
								</xsl:if>
								<xsl:if test="./instanceData/TXLife/A_TobaccoInd_PINS = '1'">
									<TobaccoInd tc="1">True</TobaccoInd>
								</xsl:if>
								<xsl:if test="./instanceData/TXLife/A_TobaccoInd_PINS = '0'">
									<TobaccoInd tc="0">False</TobaccoInd>
								</xsl:if>
							</Risk>
						</Party>
					</xsl:if>
					<!-- PINS Party END -->
					<!-- Producer AGT Party -->
					<xsl:for-each select="instanceData/TXLife/*">
						<xsl:if test="starts-with(name(),'A_AgentID_AGT')">
							<xsl:if test="string-length(.) > 0">
								<xsl:variable name="pos" select="substring(name(),14)" />
								<xsl:variable name="agentValue"
									select='format-number(../*[name()="A_COUNT_TOTAL_AGT"], "0")' />
								<xsl:variable name="posValue" select='format-number($pos, "0")' />
								<xsl:if test="$pos != '' and $posValue &lt;= $agentValue">
									<xsl:if
										test="string-length(../*[name()=concat('A_FirstName_AGT',$pos)])>0 or 
											string-length(../*[name()=concat('A_LastName_AGT',$pos)])>0">
										<Party>
											<xsl:attribute name="id">
												<xsl:value-of select="concat('Party_AGT',$pos)" />
											</xsl:attribute>
											<PartyTypeCode tc="1">Person</PartyTypeCode>
											<Person>
												<FirstName>
													<xsl:value-of select="../*[name()=concat('A_FirstName_AGT',$pos)]" />
												</FirstName>
												<xsl:if
													test="string-length(../*[name()=concat('A_MiddleName_AGT',$pos)])	> 0">
													<MiddleName>
														<xsl:value-of
															select="../*[name()=concat('A_MiddleName_AGT',$pos)]" />
													</MiddleName>
												</xsl:if>
												<LastName>
													<xsl:value-of select="../*[name()=concat('A_LastName_AGT',$pos)]" />
												</LastName>
												<xsl:if test="../*[name()=concat('A_Prefix_AGT',$pos)] != '-1'">
													<Prefix>
														<xsl:value-of select="../*[name()=concat('A_Prefix_AGT',$pos)]" />
													</Prefix>
												</xsl:if>
												<xsl:if test="../*[name()=concat('A_Suffix_AGT',$pos)] != '-1'">
													<Suffix>
														<xsl:value-of select="../*[name()=concat('A_Suffix_AGT',$pos)]" />
													</Suffix>
												</xsl:if>
											</Person>
											<xsl:if
												test="string-length(../*[name()=concat('A_Phone_AGT',$pos)])>0">
												<Phone>
													<xsl:attribute name="id">
														<xsl:value-of select="concat('Phone_AGT',$pos)" />
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
												<!-- AMERNBA-1776 -->
												<xsl:if test=" ../*[name()='A_ApplicationJurisdiction'] = 	'12'">
													<License>
														<xsl:attribute name="id">
															<xsl:value-of select="concat('License_AGT',$pos)" />
														</xsl:attribute>
														<LicenseID>
															<xsl:value-of
																select="../*[name()=concat('A_LicenseNoFL_AGT',$pos)]" />
														</LicenseID>
														<LicenseState tc="12">FL</LicenseState>
													</License>
												</xsl:if>
												<!-- AMERNBA-1776 -->
												<CarrierAppointment>
													<CompanyProducerID>
														<xsl:value-of select="../*[name()=concat('A_AgentID_AGT',$pos)]" />
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
					<!-- Owner Party START -->
					<xsl:if test="string-length(./instanceData/TXLife/A_PIOtherThanOwn)= 1">
						<xsl:for-each select="instanceData/TXLife/*">
							<xsl:if test="starts-with(name(),'A_FirstName_OWN') ">
								<xsl:variable name="pos" select="substring(name(),16)" />
								<xsl:variable name="agentValue"
									select='format-number(../*[name()="A_COUNT_TOTAL_OWN"], "0")' />
								<xsl:variable name="posValue" select='format-number($pos, "0")' />
								<xsl:if test="$pos != '' and $posValue &lt;= $agentValue">
									<xsl:if
										test="../*[name()=concat('A_OwnerTypeLife_OWN',$pos)] = '100' and 
											(string-length(../*[name()=concat('A_FirstName_OWN',$pos)]) > 0 or 
											string-length(../*[name()=concat('A_LastName_OWN',$pos)]) > 0) ">
										<Party>
											<xsl:attribute name="id">
													<xsl:value-of select="concat('Party_OWN',$pos)" />
												</xsl:attribute>
											<PartyTypeCode tc="1">Person</PartyTypeCode>
											<xsl:if
												test="string-length(../*[name()=concat('A_GovtID_SSN_OWN',$pos)]) > 0">
												<GovtID>
													<xsl:value-of
														select="translate(../*[name()=concat('A_GovtID_SSN_OWN',$pos)],'-','')" />
												</GovtID>
												<GovtIDTC tc="1">Social Security Number</GovtIDTC>
											</xsl:if>
											<xsl:if
												test="(../*[name()=concat('A_ResidencyCountry_OWN',$pos)]) != '-1'">
												<ResidenceCountry>
													<xsl:attribute name="tc">
																<xsl:value-of
														select="../*[name()=concat('A_ResidencyCountry_OWN',$pos)]" />
															</xsl:attribute>
													<xsl:value-of
														select="../*[name()=concat('A_ResidencyCountry_OWN',$pos, '_Desc')]" />
												</ResidenceCountry>
											</xsl:if>
											<Person>
												<FirstName>
													<xsl:value-of select="../*[name()=concat('A_FirstName_OWN',$pos)]" />
												</FirstName>
												<xsl:if
													test="string-length(../*[name()=concat('A_MiddleName_OWN',$pos)])	>  0">
													<MiddleName>
														<xsl:value-of
															select="../*[name()=concat('A_MiddleName_OWN',$pos)]" />
													</MiddleName>
												</xsl:if>
												<LastName>
													<xsl:value-of select="../*[name()=concat('A_LastName_OWN',$pos)]" />
												</LastName>
												<xsl:if test="../*[name()=concat('A_Prefix_OWN',$pos)] != '-1'">
													<Prefix>
														<xsl:value-of select="../*[name()=concat('A_Prefix_OWN',$pos)]" />
													</Prefix>
												</xsl:if>
												<xsl:if test="../*[name()=concat('A_Suffix_OWN',$pos)] != '-1'">
													<Suffix>
														<xsl:value-of select="../*[name()=concat('A_Suffix_OWN',$pos)]" />
													</Suffix>
												</xsl:if>
												<xsl:if
													test="string-length(../*[name()=concat('A_DOB_OWN',$pos)])	>  0">
													<BirthDate>
														<xsl:call-template name="FormatDate">
															<xsl:with-param name="Separator">
																/
															</xsl:with-param>
															<xsl:with-param name="DateString">
																<xsl:value-of select="../*[name()=concat('A_DOB_OWN',$pos)]" />
															</xsl:with-param>
														</xsl:call-template>
													</BirthDate>
												</xsl:if>
												<xsl:if
													test="string-length(../*[name()=concat('A_IDNum_OWN',$pos)]) > 0 and ../*[name()=concat('A_IDType_OWN',$pos)] = '17'">
													<PassportNo>
														<xsl:value-of select="../*[name()=concat('A_IDNum_OWN',$pos)]" />
													</PassportNo>
												</xsl:if>
												<xsl:if
													test="../*[name()=concat('A_Citizenship_OWN',$pos)] != '-1'">
													<Citizenship>
														<xsl:attribute name="tc">
																	<xsl:value-of
															select="../*[name()=concat('A_Citizenship_OWN',$pos)]" />
																</xsl:attribute>
														<xsl:value-of
															select="../*[name()=concat('A_Citizenship_OWN',$pos, '_Desc')]" />
													</Citizenship>
												</xsl:if>
												<!--xsl:if test="../*[name()=concat('A_Citizenship_OWN',$pos)] 
													= '1'"> <Citizenship tc="1">United States of America</Citizenship> </xsl:if -->
												<xsl:if test="../*[name()=concat('A_IDType_OWN',$pos)] = '29'">
													<DriversLicenseNum>
														<xsl:value-of select="../*[name()=concat('A_IDNum_OWN',$pos)]" />
													</DriversLicenseNum>
													<xsl:if
														test="../*[name()=concat('A_IssuerIDState_OWN',$pos)] != '-1'">
														<DriversLicenseState>
															<xsl:attribute name="tc">
																	<xsl:value-of
																select="../*[name()=concat('A_IssuerIDState_OWN',$pos)]" />
																</xsl:attribute>
															<xsl:value-of
																select="../*[name()=concat('A_IssuerIDState_OWN',$pos, '_Desc')]" />
														</DriversLicenseState>
													</xsl:if>
												</xsl:if>
												<OLifEExtension ExtensionCode="Party 2.8.90"
													VendorCode="05">
													<PersonExtension>
														<xsl:if test="../*[name()=concat('A_ValidUSDL_OWN',$pos)]= '1'">
															<ValidDLInd tc="1">true</ValidDLInd>
														</xsl:if>
														<xsl:if test="../*[name()=concat('A_ValidUSDL_OWN',$pos)]= '0'">
															<ValidDLInd tc="0">false</ValidDLInd>
														</xsl:if>
														<xsl:if
															test="../*[name()=concat('A_IDType_OWN',$pos)] != '29' and ../*[name()=concat('A_IDType_OWN',$pos)] != '-1' ">
															<GovtIDInfo>
																<xsl:attribute name="id">
															<xsl:value-of select="concat('GovtIDInfo_OWN',$pos)" />
															</xsl:attribute>
																<GovtID>
																	<xsl:value-of select="../*[name()=concat('A_IDNum_OWN',$pos)]" />
																</GovtID>
																<!-- Modified by Puja, BHFD-1112 Start -->
																<ExpDate>
																	<xsl:call-template name="FormatDate">
																		<xsl:with-param name="Separator">
																			/
																		</xsl:with-param>
																		<xsl:with-param name="DateString">
																			<xsl:value-of
																				select="../*[name()=concat('A_IDExpirationDate_OWN',$pos)]" />
																		</xsl:with-param>
																	</xsl:call-template>
																</ExpDate>
																<IssueDate>
																	<xsl:call-template name="FormatDate">
																		<xsl:with-param name="Separator">
																			/
																		</xsl:with-param>
																		<xsl:with-param name="DateString">
																			<xsl:value-of
																				select="../*[name()=concat('A_IDIssueDate_OWN',$pos)]" />
																		</xsl:with-param>
																	</xsl:call-template>
																</IssueDate>
																<!-- Modified by Puja, BHFD-1112 End -->
																<xsl:if
																	test="../*[name()=concat('A_IDType_OWN',$pos)] != '-1'">
																	<GovtIDTC>
																		<xsl:attribute name="tc">
																			<xsl:value-of
																			select="../*[name()=concat('A_IDType_OWN',$pos)]" />
																		</xsl:attribute>
																		<xsl:value-of
																			select="../*[name()=concat('A_IDType_OWN',$pos, '_Desc')]" />
																	</GovtIDTC>
																</xsl:if>
																<xsl:if
																	test="../*[name()=concat('A_IssuerIDCountry_OWN',$pos)] != '-1'">
																	<Nation>
																		<xsl:attribute name="tc">
																			<xsl:value-of
																			select="../*[name()=concat('A_IssuerIDCountry_OWN',$pos)]" />
																		</xsl:attribute>
																		<xsl:value-of
																			select="../*[name()=concat('A_IssuerIDCountry_OWN',$pos, '_Desc')]" />
																	</Nation>
																</xsl:if>
																<xsl:if
																	test="../*[name()=concat('A_IssuerIDState_OWN',$pos)] != '-1'">
																	<Jurisdiction>
																		<xsl:attribute name="tc">
																			<xsl:value-of
																			select="../*[name()=concat('A_IssuerIDState_OWN',$pos)]" />
																		</xsl:attribute>
																		<xsl:value-of
																			select="../*[name()=concat('A_IssuerIDState_OWN',$pos, '_Desc')]" />
																	</Jurisdiction>
																</xsl:if>
																<!-- BHFD-1112 renamed TAG and moved up the position -->
																<!-- <GovtIDIssDate> <xsl:call-template name="FormatDate"> 
																	<xsl:with-param name="Separator"> / </xsl:with-param> <xsl:with-param name="DateString"> 
																	<xsl:value-of select="../*[name()=concat('A_IDIssueDate_OWN',$pos)]" /> </xsl:with-param> 
																	</xsl:call-template> </GovtIDIssDate> <GovtIDExpDate> <xsl:call-template 
																	name="FormatDate"> <xsl:with-param name="Separator"> / </xsl:with-param> 
																	<xsl:with-param name="DateString"> <xsl:value-of select="../*[name()=concat('A_IDExpiratnDate_OWN',$pos)]" 
																	/> </xsl:with-param> </xsl:call-template> </GovtIDExpDate> -->
															</GovtIDInfo>
														</xsl:if>
													</PersonExtension>
												</OLifEExtension>
											</Person>
											<Address>
												<xsl:attribute name="id">
													   <xsl:value-of select="concat('Address_OWN',$pos)" />
											    </xsl:attribute>
												<AddressTypeCode tc="1">Home</AddressTypeCode>
												<xsl:if
													test="string-length(../*[name()=concat('A_AddressLine1_OWN',$pos)]) > 0">
													<AttentionLine>
														<xsl:value-of
															select="../*[name()=concat('A_AddressLine1_OWN',$pos)]" />
													</AttentionLine>
												</xsl:if>
												<xsl:if
													test="string-length(../*[name()=concat('A_AddressLine2_OWN',$pos)]) > 0">
													<Line1>
														<xsl:value-of
															select="../*[name()=concat('A_AddressLine2_OWN',$pos)]" />
													</Line1>
												</xsl:if>
												<xsl:if
													test="string-length(../*[name()=concat('A_AddressLine3_OWN',$pos)]) > 0">
													<Line2>
														<xsl:value-of
															select="../*[name()=concat('A_AddressLine3_OWN',$pos)]" />
													</Line2>
												</xsl:if>
												<xsl:if
													test="string-length(../*[name()=concat('A_AddressLine4_OWN',$pos)]) > 0">
													<Line3>
														<xsl:value-of
															select="../*[name()=concat('A_AddressLine4_OWN',$pos)]" />
													</Line3>
												</xsl:if>
												<xsl:if
													test="string-length(../*[name()=concat('A_City_OWN',$pos)]) > 0">
													<City>
														<xsl:value-of select="../*[name()=concat('A_City_OWN',$pos)]" />
													</City>
												</xsl:if>
												<xsl:if test="(../*[name()=concat('A_State_OWN',$pos)]) != '-1'">
													<AddressStateTC>
														<xsl:attribute name="tc">
																	<xsl:value-of
															select="../*[name()=concat('A_State_OWN',$pos)]" />
																</xsl:attribute>
														<xsl:value-of
															select="../*[name()=concat('A_State_OWN',$pos, '_Desc')]" />
													</AddressStateTC>
												</xsl:if>
												<xsl:choose>
													<xsl:when
														test="contains(../*[name()=concat('A_ZipCode_OWN',$pos)] ,'-')">
														<Zip>
															<xsl:value-of
																select="translate(../*[name()=concat('A_ZipCode_OWN',$pos)],'-','')" />
														</Zip>
													</xsl:when>
													<xsl:when
														test="not(contains(../*[name()=concat('A_ZipCode_OWN',$pos)] ,'-'))">
														<Zip>
															<xsl:value-of select="../*[name()=concat('A_ZipCode_OWN',$pos)]" />
														</Zip>
													</xsl:when>
												</xsl:choose>
											</Address>
											<xsl:if
												test="string-length(../*[name()=concat('A_Phone1_OWN',$pos)])>0">
												<Phone>
													<xsl:attribute name="id">
													   <xsl:value-of select="concat('Phone_OWN',$pos)" />
											        </xsl:attribute>
													<PhoneTypeCode tc="1">Home</PhoneTypeCode>
													<AreaCode>
														<xsl:value-of
															select="substring(../*[name()=concat('A_Phone1_OWN',$pos)],1,3)" />
													</AreaCode>
													<DialNumber>
														<xsl:value-of
															select="substring(../*[name()=concat('A_Phone1_OWN',$pos)],4)" />
													</DialNumber>
												</Phone>
											</xsl:if>
											<!-- BHFD-1129 -->
											<xsl:if
												test="string-length(../*[name()=concat('A_EmailAddress1_OWN',$pos)]) > 0">
												<EMailAddress>
													<xsl:attribute name="id">
																<xsl:value-of select="concat('EMailAddress1_OWN',$pos)" />
															</xsl:attribute>
													<EMailType tc="2">Personal</EMailType>
													<AddrLine>
														<xsl:value-of
															select="../*[name()=concat('A_EmailAddress1_OWN',$pos)]" />
													</AddrLine>
												</EMailAddress>
											</xsl:if>
											<xsl:if
												test="string-length(../*[name()=concat('A_EmailAddress1_OWN',$pos)]) > 0 and ../A_EDElected = '0'">
												<EMailAddress>
													<xsl:attribute name="id">
																<xsl:value-of select="concat('EMailAddress2_OWN',$pos)" />
															</xsl:attribute>
													<EMailType tc="1000500001">eDelivery</EMailType>
													<AddrLine>
														<xsl:value-of
															select="../*[name()=concat('A_EmailAddress1_OWN',$pos)]" />
													</AddrLine>
												</EMailAddress>
											</xsl:if>
										</Party>
									</xsl:if>
									<!-- Entity OWN Party -->
									<xsl:if
										test="../*[name()=concat('A_OwnerTypeLife_OWN',$pos)] != '100' and 
											(string-length(../*[name()=concat('A_EntityName_OWN',$pos)]) > 0)">
										<Party>
											<xsl:attribute name="id">
													<xsl:value-of select="concat('Party_ENTITY',$pos)" />
												</xsl:attribute>
											<PartyTypeCode tc="2">Organization</PartyTypeCode>
											<FullName>
												<xsl:value-of select="../*[name()=concat('A_EntityName_OWN',$pos)]" />
											</FullName>
											<xsl:if
												test="string-length(../*[name()=concat('A_GovtID_TID_OWN',$pos)]) > 0">
												<GovtID>
													<xsl:value-of
														select="translate(../*[name()=concat('A_GovtID_TID_OWN',$pos)],'-','')" />
												</GovtID>
												<GovtIDTC tc="2">Tax ID Number</GovtIDTC>
											</xsl:if>
											<Organization>
												<OrgForm>
													<xsl:attribute name="tc">
																<xsl:value-of
														select="../*[name()=concat('A_OwnerTypeLife_OWN',$pos)]" />
															</xsl:attribute>
													<xsl:value-of
														select="../*[name()=concat('A_OwnerTypeLife_OWN',$pos, '_Desc')]" />
												</OrgForm>
												<xsl:if
													test="../*[name()=concat('A_OwnerTypeLife_OWN',$pos)] = '16'">
													<EstabDate>
														<xsl:call-template name="FormatDate">
															<xsl:with-param name="Separator">
																/
															</xsl:with-param>
															<xsl:with-param name="DateString">
																<xsl:value-of
																	select="../*[name()=concat('A_DOTrust_OWN',$pos)]" />
															</xsl:with-param>
														</xsl:call-template>
													</EstabDate>
												</xsl:if>
												<DBA>
													<xsl:value-of
														select="../*[name()=concat('A_EntityName_OWN',$pos)]" />
												</DBA>
												<!-- BHFD-576 -->
												<xsl:if
													test="../*[name()=concat('A_TrustState_OWN',$pos)] != '-1'">
													<OLifEExtension ExtensionCode="Organization 2.8.90"
														VendorCode="05">
														<OrganizationExtension>
															<TrustState>
																<xsl:attribute name="tc">
																		<xsl:value-of
																	select="../*[name()=concat('A_TrustState_OWN',$pos)]" />
																	</xsl:attribute>
																<xsl:value-of
																	select="../*[name()=concat('A_TrustState_OWN',$pos, '_Desc')]" />
															</TrustState>
														</OrganizationExtension>
													</OLifEExtension>
												</xsl:if>
											</Organization>
											<Address>
												<xsl:attribute name="id">
													<xsl:value-of select="concat('Address_OWN',$pos)" />
												</xsl:attribute>
												<AddressTypeCode tc="2">Business
												</AddressTypeCode>
												<xsl:if
													test="string-length(../*[name()=concat('A_AddressLine1_OWN',$pos)]) > 0">
													<AttentionLine>
														<xsl:value-of
															select="../*[name()=concat('A_AddressLine1_OWN',$pos)]" />
													</AttentionLine>
												</xsl:if>
												<xsl:if
													test="string-length(../*[name()=concat('A_AddressLine2_OWN',$pos)]) > 0">
													<Line1>
														<xsl:value-of
															select="../*[name()=concat('A_AddressLine2_OWN',$pos)]" />
													</Line1>
												</xsl:if>
												<xsl:if
													test="string-length(../*[name()=concat('A_AddressLine3_OWN',$pos)]) > 0">
													<Line2>
														<xsl:value-of
															select="../*[name()=concat('A_AddressLine3_OWN',$pos)]" />
													</Line2>
												</xsl:if>
												<xsl:if
													test="string-length(../*[name()=concat('A_AddressLine4_OWN',$pos)]) > 0">
													<Line3>
														<xsl:value-of
															select="../*[name()=concat('A_AddressLine4_OWN',$pos)]" />
													</Line3>
												</xsl:if>
												<xsl:if
													test="string-length(../*[name()=concat('A_City_OWN',$pos)]) > 0">
													<City>
														<xsl:value-of select="../*[name()=concat('A_City_OWN',$pos)]" />
													</City>
												</xsl:if>
												<xsl:if test="(../*[name()=concat('A_State_OWN',$pos)]) != '-1'">
													<AddressStateTC>
														<xsl:attribute name="tc">
																	<xsl:value-of
															select="../*[name()=concat('A_State_OWN',$pos)]" />
																</xsl:attribute>
														<xsl:value-of
															select="../*[name()=concat('A_State_OWN',$pos, '_Desc')]" />
													</AddressStateTC>
												</xsl:if>
												<xsl:choose>
													<xsl:when
														test="contains(../*[name()=concat('A_ZipCode_OWN',$pos)] ,'-')">
														<Zip>
															<xsl:value-of
																select="translate(../*[name()=concat('A_ZipCode_OWN',$pos)],'-','')" />
														</Zip>
													</xsl:when>
													<xsl:when
														test="not(contains(../*[name()=concat('A_ZipCode_OWN',$pos)] ,'-'))">
														<Zip>
															<xsl:value-of select="../*[name()=concat('A_ZipCode_OWN',$pos)]" />
														</Zip>
													</xsl:when>
												</xsl:choose>
											</Address>
											<xsl:if
												test="string-length(../*[name()=concat('A_Phone_OWN',$pos)])>0">
												<Phone>
													<xsl:attribute name="id">
													   <xsl:value-of select="concat('Phone_OWN',$pos)" />
											        </xsl:attribute>
													<PhoneTypeCode tc="2">Business</PhoneTypeCode>
													<AreaCode>
														<xsl:value-of
															select="substring(../*[name()=concat('A_Phone_OWN',$pos)],1,3)" />
													</AreaCode>
													<DialNumber>
														<xsl:value-of
															select="substring(../*[name()=concat('A_Phone_OWN',$pos)],4)" />
													</DialNumber>
												</Phone>
											</xsl:if>
											<xsl:if
												test="string-length(../*[name()=concat('A_EmailAddress_OWN',$pos)]) > 0">
												<EMailAddress>
													<xsl:attribute name="id">
																<xsl:value-of select="concat('EMailAddress_OWN',$pos)" />
															</xsl:attribute>
													<EMailType tc="1">Business</EMailType>
													<AddrLine>
														<xsl:value-of
															select="../*[name()=concat('A_EmailAddress_OWN',$pos)]" />
													</AddrLine>
												</EMailAddress>
											</xsl:if>
											<xsl:if
												test="../A_EDElected = '0' and string-length(../*[name()=concat('A_EmailAddress_OWN',$pos)]) > 0">
												<EMailAddress>
													<xsl:attribute name="id">
																<xsl:value-of select="concat('EMailAddress2_OWN',$pos)" />
															</xsl:attribute>
													<EMailType tc="1000500001">eDelivery</EMailType>
													<AddrLine>
														<xsl:value-of
															select="../*[name()=concat('A_EmailAddress_OWN',$pos)]" />
													</AddrLine>
												</EMailAddress>
											</xsl:if>
										</Party>
									</xsl:if>
									<!-- Entity OWN Party END -->
								</xsl:if>
							</xsl:if>
						</xsl:for-each>
					</xsl:if>
					<!-- Owner Party END -->
					<!-- Custodian Owner party -->
					<xsl:if test="string-length(./instanceData/TXLife/A_PIOtherThanOwn)= 1">
						<xsl:for-each select="instanceData/TXLife/*">
							<xsl:if test="starts-with(name(),'A_CustFirstName_OWN')">
								<xsl:if test="string-length(.) > 0">
									<xsl:variable name="pos" select="substring(name(),20)" />
									<xsl:variable name="agentValue"
										select='format-number(../*[name()="A_COUNT_TOTAL_OWN"], "0")' />
									<xsl:variable name="posValue" select='format-number($pos, "0")' />
									<xsl:if test="$pos != '' and $posValue &lt;= $agentValue">
										<xsl:if
											test="string-length(../*[name()=concat('A_CustFirstName_OWN',$pos)])>0 or string-length(../*[name()=concat('A_CustLastName_OWN',$pos)])>'0'">
											<Party>
												<xsl:attribute name="id">
														<xsl:value-of select="concat('Party_Custodian_OWN',$pos)" />
													</xsl:attribute>
												<PartyTypeCode tc="1">Person</PartyTypeCode>
												<Person>
													<FirstName>
														<xsl:value-of
															select="../*[name()=concat('A_CustFirstName_OWN',$pos)]" />
													</FirstName>
													<xsl:if
														test="string-length(../*[name()=concat('A_MiddleName_OWN',$pos)])	>  0">
														<MiddleName>
															<xsl:value-of
																select="../*[name()=concat('A_CustMiddleName_OWN',$pos)]" />
														</MiddleName>
													</xsl:if>
													<LastName>
														<xsl:value-of
															select="../*[name()=concat('A_CustLastName_OWN',$pos)]" />
													</LastName>
													<xsl:if
														test="../*[name()=concat('A_CustPrefix_OWN',$pos)] != '-1'">
														<Prefix>
															<xsl:value-of
																select="../*[name()=concat('A_CustPrefix_OWN',$pos)]" />
														</Prefix>
													</xsl:if>
													<xsl:if
														test="../*[name()=concat('A_CustSuffix_OWN',$pos)] != '-1'">
														<Suffix>
															<xsl:value-of
																select="../*[name()=concat('A_CustSuffix_OWN',$pos)]" />
														</Suffix>
													</xsl:if>
													<xsl:if
														test="../*[name()=concat('A_CustIDType_OWN',$pos)] = '3'">
														<xsl:if
															test="string-length(../*[name()=concat('A_CustIDNum_OWN',$pos)])	>  0">
															<PassportNo>
																<xsl:value-of
																	select="../*[name()=concat('A_CustIDNum_OWN',$pos)]" />
															</PassportNo>
														</xsl:if>
													</xsl:if>
													<xsl:if
														test="../*[name()=concat('A_CustIDType_OWN',$pos)] = '1'">
														<DriversLicenseNum>
															<xsl:value-of
																select="../*[name()=concat('A_CustIDNum_OWN',$pos)]" />
														</DriversLicenseNum>
														<!--BHFD-1137 -->
														<xsl:if
															test="../*[name()=concat('A_CustIssuerIDState_OWN',$pos)] != '-1'">
															<DriversLicenseState>
																<xsl:attribute name="tc">
																	<xsl:value-of
																	select="../*[name()=concat('A_CustIssuerIDState_OWN',$pos)]" />
																</xsl:attribute>
																<xsl:value-of
																	select="../*[name()=concat('A_CustIssuerIDState_OWN',$pos, '_Desc')]" />
															</DriversLicenseState>
														</xsl:if>
													</xsl:if>
													<xsl:if
														test="../*[name()=concat('A_CustIDType_OWN',$pos)] != '1' and ../*[name()=concat('A_CustIDType_OWN',$pos)] != '-1' ">
														<OLifEExtension ExtensionCode="Party on 2.8.90"
															VendorCode="05">
															<PersonExtension>
																<GovtIDInfo>
																	<xsl:attribute name="id">
																				<xsl:value-of select="concat('CustGovtID_OWN',$pos)" />
																			</xsl:attribute>
																	<GovtID>
																		<xsl:value-of
																			select="../*[name()=concat('A_CustIDNum_OWN',$pos)]" />
																	</GovtID>
																	<!-- Modified by Puja, BHFD-1112 Start -->
																	<ExpDate>
																		<xsl:call-template name="FormatDate">
																			<xsl:with-param name="Separator">
																				/
																			</xsl:with-param>
																			<xsl:with-param name="DateString">
																				<xsl:value-of
																					select="../*[name()=concat('A_CustIDExpirationDate_OWN',$pos)]" />
																			</xsl:with-param>
																		</xsl:call-template>
																	</ExpDate>
																	<IssueDate>
																		<xsl:call-template name="FormatDate">
																			<xsl:with-param name="Separator">
																				/
																			</xsl:with-param>
																			<xsl:with-param name="DateString">
																				<xsl:value-of
																					select="../*[name()=concat('A_CustIDIssueDate_OWN',$pos)]" />
																			</xsl:with-param>
																		</xsl:call-template>
																	</IssueDate>
																	<!-- Modified by Puja, BHFD-1112 End -->
																	<!-- BHFD-1137 -->
																	<xsl:if
																		test="../*[name()=concat('A_CustIDType_OWN',$pos)] = '2'">
																		<GovtIDTC tc="2147483647">Government issued Photo ID</GovtIDTC>
																	</xsl:if>
																	<xsl:if
																		test="../*[name()=concat('A_CustIDType_OWN',$pos)] = '3'">
																		<GovtIDTC tc="17">Passport</GovtIDTC>
																	</xsl:if>
																	<xsl:if
																		test="../*[name()=concat('A_CustIssuerIDCountry_OWN',$pos)] != '-1'">
																		<Nation>
																			<xsl:attribute name="tc">
																				<xsl:value-of
																				select="../*[name()=concat('A_CustIssuerIDCountry_OWN',$pos)]" />
																			</xsl:attribute>
																			<xsl:value-of
																				select="../*[name()=concat('A_CustIssuerIDCountry_OWN',$pos, '_Desc')]" />
																		</Nation>
																	</xsl:if>
																	<xsl:if
																		test="../*[name()=concat('A_CustIssuerIDState_OWN',$pos)] != '-1'">
																		<Jurisdiction>
																			<xsl:attribute name="tc">
																				<xsl:value-of
																				select="../*[name()=concat('A_CustIssuerIDState_OWN',$pos)]" />
																			</xsl:attribute>
																			<xsl:value-of
																				select="../*[name()=concat('A_CustIssuerIDState_OWN',$pos, '_Desc')]" />
																		</Jurisdiction>
																	</xsl:if>
																	<!-- BHFD - 1112 renamed the TAG and moved up -->
																	<!-- <GovtIDIssDate> <xsl:call-template name="FormatDate"> 
																		<xsl:with-param name="Separator"> / </xsl:with-param> <xsl:with-param name="DateString"> 
																		<xsl:value-of select="../*[name()=concat('A_CustIDIssueDate_OWN',$pos)]" 
																		/> </xsl:with-param> </xsl:call-template> </GovtIDIssDate> <GovtIDExpDate> 
																		<xsl:call-template name="FormatDate"> <xsl:with-param name="Separator"> / 
																		</xsl:with-param> <xsl:with-param name="DateString"> <xsl:value-of select="../*[name()=concat('A_CustIDExpirationDate_OWN',$pos)]" 
																		/> </xsl:with-param> </xsl:call-template> </GovtIDExpDate> -->
																</GovtIDInfo>
															</PersonExtension>
														</OLifEExtension>
													</xsl:if>
												</Person>
												<Address>
													<xsl:attribute name="id">
														<xsl:value-of select="concat('Address_Custodian_Own',$pos)" />
														</xsl:attribute>
													<AddressTypeCode tc="1">Home</AddressTypeCode>
													<xsl:if
														test="string-length(../*[name()=concat('A_CustAddressLine1_OWN',$pos)]) > 0">
														<AttentionLine>
															<xsl:value-of
																select="../*[name()=concat('A_CustAddressLine1_OWN',$pos)]" />
														</AttentionLine>
													</xsl:if>
													<xsl:if
														test="string-length(../*[name()=concat('A_CustAddressLine2_OWN',$pos)]) > 0">
														<Line1>
															<xsl:value-of
																select="../*[name()=concat('A_CustAddressLine2_OWN',$pos)]" />
														</Line1>
													</xsl:if>
													<xsl:if
														test="string-length(../*[name()=concat('A_CustAddressLine3_OWN',$pos)]) > 0">
														<Line2>
															<xsl:value-of
																select="../*[name()=concat('A_CustAddressLine3_OWN',$pos)]" />
														</Line2>
													</xsl:if>
													<xsl:if
														test="string-length(../*[name()=concat('A_CustAddressLine4_OWN',$pos)]) > 0">
														<Line3>
															<xsl:value-of
																select="../*[name()=concat('A_CustAddressLine4_OWN',$pos)]" />
														</Line3>
													</xsl:if>
													<xsl:if
														test="string-length(../*[name()=concat('A_CustCity_OWN',$pos)]) > 0">
														<City>
															<xsl:value-of
																select="../*[name()=concat('A_CustCity_OWN',$pos)]" />
														</City>
													</xsl:if>
													<xsl:if
														test="(../*[name()=concat('A_CustState_OWN',$pos)]) != '-1'">
														<AddressStateTC>
															<xsl:attribute name="tc">
																	<xsl:value-of
																select="../*[name()=concat('A_CustState_OWN',$pos)]" />
																</xsl:attribute>
															<xsl:value-of
																select="../*[name()=concat('A_CustState_OWN',$pos, '_Desc')]" />
														</AddressStateTC>
													</xsl:if>
													<xsl:choose>
														<xsl:when
															test="contains(../*[name()=concat('A_CustZipCode_OWN',$pos)] ,'-')">
															<Zip>
																<xsl:value-of
																	select="translate(../*[name()=concat('A_CustZipCode_OWN',$pos)],'-','')" />
															</Zip>
														</xsl:when>
														<xsl:when
															test="not(contains(../*[name()=concat('A_CustZipCode_OWN',$pos)] ,'-'))">
															<Zip>
																<xsl:value-of
																	select="../*[name()=concat('A_CustZipCode_OWN',$pos)]" />
															</Zip>
														</xsl:when>
													</xsl:choose>
												</Address>
											</Party>
										</xsl:if>
									</xsl:if>
								</xsl:if>
							</xsl:if>
						</xsl:for-each>
					</xsl:if>
					<!-- Authorized Person For Entity Owner -->
					<xsl:if test="string-length(./instanceData/TXLife/A_PIOtherThanOwn)= 1">
						<xsl:for-each select="instanceData/TXLife/*">
							<xsl:if test="starts-with(name(),'A_FirstName_AUTHORIZED')">
								<xsl:if test="string-length(.) > 0">
									<xsl:variable name="pos" select="substring(name(),23)" />
									<xsl:variable name="agentValue"
										select='format-number(../*[name()="A_COUNT_TOTAL_OWN"], "0")' />
									<xsl:variable name="posValue" select='format-number($pos, "0")' />
									<xsl:if test="$pos != '' and $posValue &lt;= $agentValue">
										<xsl:if
											test="string-length(../*[name()=concat('A_FirstName_AUTHORIZED',$pos)])>0 or string-length(../*[name()=concat('A_LastName_AUTHORIZED',$pos)])>'0'">
											<Party>
												<xsl:attribute name="id">
														<xsl:value-of select="concat('Party_OWN_AUTHORIZED',$pos)" />
													</xsl:attribute>
												<PartyTypeCode tc="1">Person</PartyTypeCode>
												<Person>
													<FirstName>
														<xsl:value-of
															select="../*[name()=concat('A_FirstName_AUTHORIZED',$pos)]" />
													</FirstName>
													<xsl:if
														test="string-length(../*[name()=concat('A_MiddleName_AUTHORIZED',$pos)])>0">
														<MiddleName>
															<xsl:value-of
																select="../*[name()=concat('A_MiddleName_AUTHORIZED',$pos)]" />
														</MiddleName>
													</xsl:if>
													<LastName>
														<xsl:value-of
															select="../*[name()=concat('A_LastName_AUTHORIZED',$pos)]" />
													</LastName>
													<xsl:if
														test="../*[name()=concat('A_Prefix_AUTHORIZED',$pos)] != '-1'">
														<Prefix>
															<xsl:value-of
																select="../*[name()=concat('A_Prefix_AUTHORIZED',$pos)]" />
														</Prefix>
													</xsl:if>
													<xsl:if
														test="../*[name()=concat('A_Suffix_AUTHORIZED',$pos)] != '-1'">
														<Suffix>
															<xsl:value-of
																select="../*[name()=concat('A_Suffix_AUTHORIZED',$pos)]" />
														</Suffix>
													</xsl:if>
												</Person>
												<!-- Modified by Puja , Added Phone and Email Address tags to 
													Authorized person -->
												<xsl:if
													test="string-length(../*[name()=concat('A_Phone_OWN',$pos)])>0">
													<Phone>
														<xsl:attribute name="id"><xsl:value-of
															select="concat('Phone_OWN_Authorized',$pos)" /></xsl:attribute>
														<PhoneTypeCode tc="2">Business</PhoneTypeCode>
														<AreaCode>
															<xsl:value-of
																select="substring(../*[name()=concat('A_Phone_OWN',$pos)],1,3)" />
														</AreaCode>
														<DialNumber>
															<xsl:value-of
																select="substring(../*[name()=concat('A_Phone_OWN',$pos)],4)" />
														</DialNumber>
													</Phone>
												</xsl:if>
												<xsl:if
													test="string-length(../*[name()=concat('A_EmailAddress_OWN',$pos)]) > 0">
													<EMailAddress>
														<xsl:attribute name="id"><xsl:value-of
															select="concat('EMailAddress_OWN_Authorized',$pos)" /></xsl:attribute>
														<EMailType tc="1">Business</EMailType>
														<AddrLine>
															<xsl:value-of
																select="../*[name()=concat('A_EmailAddress_OWN',$pos)]" />
														</AddrLine>
													</EMailAddress>
												</xsl:if>
											</Party>
										</xsl:if>
									</xsl:if>
								</xsl:if>
							</xsl:if>
						</xsl:for-each>
					</xsl:if>
					<!-- Custodian for Primary Beneficiary Party -->
					<xsl:for-each select="instanceData/TXLife/*">
						<xsl:if test="starts-with(name(),'A_CustFirstName_BEN')">
							<xsl:if test="string-length(.) > 0">
								<xsl:variable name="pos" select="substring(name(),20)" />
								<xsl:variable name="agentValue"
									select='format-number(../*[name()="A_COUNT_TOTAL_BEN"], "0")' />
								<xsl:variable name="posValue" select='format-number($pos, "0")' />
								<xsl:if test="$pos != '' and $posValue &lt;= $agentValue">
									<xsl:if
										test="string-length(../*[name()=concat('A_CustFirstName_BEN',$pos)])>0 or string-length(../*[name()=concat('A_CustLastName_BEN',$pos)])>0">
										<Party>
											<xsl:attribute name="id">
													<xsl:value-of select="concat('Party_Custodian_BEN',$pos)" />
												</xsl:attribute>
											<PartyTypeCode tc="1">Person</PartyTypeCode>
											<Person>
												<FirstName>
													<xsl:value-of
														select="../*[name()=concat('A_CustFirstName_BEN',$pos)]" />
												</FirstName>
												<xsl:if
													test="string-length(../*[name()=concat('A_CustMiddleName_BEN',$pos)])	>  0">
													<MiddleName>
														<xsl:value-of
															select="../*[name()=concat('A_CustMiddleName_BEN',$pos)]" />
													</MiddleName>
												</xsl:if>
												<LastName>
													<xsl:value-of
														select="../*[name()=concat('A_CustLastName_BEN',$pos)]" />
												</LastName>
												<xsl:if
													test="../*[name()=concat('A_CustPrefix_BEN',$pos)] != '-1'">
													<Prefix>
														<xsl:value-of
															select="../*[name()=concat('A_CustPrefix_BEN',$pos)]" />
													</Prefix>
												</xsl:if>
												<xsl:if
													test="../*[name()=concat('A_CustSuffix_BEN',$pos)] != '-1'">
													<Suffix>
														<xsl:value-of
															select="../*[name()=concat('A_CustSuffix_BEN',$pos)]" />
													</Suffix>
												</xsl:if>
											</Person>
										</Party>
									</xsl:if>
								</xsl:if>
							</xsl:if>
						</xsl:if>
					</xsl:for-each>
					<!-- Custodian for Contigent Beneficiary Party -->
					<xsl:for-each select="instanceData/TXLife/*">
						<xsl:if test="starts-with(name(),'A_CustFirstName_CBN')">
							<xsl:if test="string-length(.) > 0">
								<xsl:variable name="pos" select="substring(name(),20)" />
								<xsl:variable name="agentValue"
									select='format-number(../*[name()="A_COUNT_TOTAL_CBN"], "0")' />
								<xsl:variable name="posValue" select='format-number($pos, "0")' />
								<xsl:if test="$pos != '' and $posValue &lt;= $agentValue">
									<xsl:if
										test="string-length(../*[name()=concat('A_CustFirstName_CBN',$pos)])>0 or string-length(../*[name()=concat('A_CustLastName_CBN',$pos)])>0">
										<Party>
											<xsl:attribute name="id">
													<xsl:value-of select="concat('Party_Custodian_CBN',$pos)" />
												</xsl:attribute>
											<PartyTypeCode tc="1">Person</PartyTypeCode>
											<Person>
												<FirstName>
													<xsl:value-of
														select="../*[name()=concat('A_CustFirstName_CBN',$pos)]" />
												</FirstName>
												<xsl:if
													test="string-length(../*[name()=concat('A_CustMiddleName_CBN',$pos)])	>  0">
													<MiddleName>
														<xsl:value-of
															select="../*[name()=concat('A_CustMiddleName_CBN',$pos)]" />
													</MiddleName>
												</xsl:if>
												<LastName>
													<xsl:value-of
														select="../*[name()=concat('A_CustLastName_CBN',$pos)]" />
												</LastName>
												<xsl:if
													test="../*[name()=concat('A_CustPrefix_CBN',$pos)] != '-1'">
													<Prefix>
														<xsl:value-of
															select="../*[name()=concat('A_CustPrefix_CBN',$pos)]" />
													</Prefix>
												</xsl:if>
												<xsl:if
													test="../*[name()=concat('A_CustSuffix_CBN',$pos)] != '-1'">
													<Suffix>
														<xsl:value-of
															select="../*[name()=concat('A_CustSuffix_CBN',$pos)]" />
													</Suffix>
												</xsl:if>
											</Person>
										</Party>
									</xsl:if>
								</xsl:if>
							</xsl:if>
						</xsl:if>
					</xsl:for-each>
					<!-- Payor party -->
					<xsl:if
						test="(./instanceData/TXLife/A_PayorType) !='-1' and (./instanceData/TXLife/A_PremPayor) ='3' and 
						(string-length(./instanceData/TXLife/A_EntityName_PYR))  >  0 or
						(string-length(./instanceData/TXLife/A_FirstName_PYR))  >  0 or
						(string-length(./instanceData/TXLife/A_LastName_PYR))  >  0">
						<Party id="Party_PYR">
							<xsl:if test="(./instanceData/TXLife/A_PayorType) != '100'">
								<PartyTypeCode tc="2">Organization</PartyTypeCode>
								<FullName>
									<xsl:value-of select="instanceData/TXLife/A_EntityName_PYR" />
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
									<OrgForm>
										<xsl:attribute name="tc">
											<xsl:value-of select="instanceData/TXLife/A_PayorType" />
										</xsl:attribute>
										<xsl:value-of select="instanceData/TXLife/A_PayorType_Desc" />
									</OrgForm>
									<DBA>
										<xsl:value-of select="instanceData/TXLife/A_EntityName_PYR" />
									</DBA>
								</Organization>
							</xsl:if>
							<xsl:if test="./instanceData/TXLife/A_PayorType = '100'">
								<PartyTypeCode tc="1">Person</PartyTypeCode>
								<!-- BHFD-1172 -->
								<xsl:if
									test="string-length(./instanceData/TXLife/A_GovtID_SSN_PYR) > 0 and ./instanceData/TXLife/A_GovtIDTC_PYR = '1' ">
									<GovtID>
										<xsl:value-of
											select="translate(./instanceData/TXLife/A_GovtID_SSN_PYR,'-','')" />
									</GovtID>
									<GovtIDTC tc="1">Social Security Number</GovtIDTC>
								</xsl:if>
								<!-- BHFD-1172 -->
								<xsl:if
									test="string-length(./instanceData/TXLife/A_GovtID_TID_CPYR) > 0 and ./instanceData/TXLife/A_GovtIDTC_PYR = '2' ">
									<GovtID>
										<xsl:value-of
											select="translate(./instanceData/TXLife/A_GovtID_TID_CPYR,'-','')" />
									</GovtID>
									<GovtIDTC tc="2">Taxpayer Identification Number</GovtIDTC>
								</xsl:if>
								<ResidenceCountry>
									<xsl:attribute name="tc">
										<xsl:value-of select="instanceData/TXLife/A_ResidencyCountry_PYR" />
									</xsl:attribute>
									<xsl:value-of select="instanceData/TXLife/A_ResidencyCountry_PYR_Desc" />
								</ResidenceCountry>
								<Person>
									<FirstName>
										<xsl:value-of select="instanceData/TXLife/A_FirstName_PYR" />
									</FirstName>
									<xsl:if
										test="string-length(./instanceData/TXLife/A_MiddleName_PYR) > 0">
										<MiddleName>
											<xsl:value-of select="instanceData/TXLife/A_MiddleName_PYR" />
										</MiddleName>
									</xsl:if>
									<LastName>
										<xsl:value-of select="instanceData/TXLife/A_LastName_PYR" />
									</LastName>
									<xsl:if test="./instanceData/TXLife/A_Prefix_PYR != '-1'">
										<Prefix>
											<xsl:value-of select="instanceData/TXLife/A_Prefix_PYR" />
										</Prefix>
									</xsl:if>
									<xsl:if test="./instanceData/TXLife/A_Suffix_PYR != '-1'">
										<Suffix>
											<xsl:value-of select="instanceData/TXLife/A_Suffix_PYR" />
										</Suffix>
									</xsl:if>
									<BirthDate>
										<xsl:call-template name="FormatDate">
											<xsl:with-param name="Separator">
												/
											</xsl:with-param>
											<xsl:with-param name="DateString">
												<xsl:value-of select="instanceData/TXLife/A_DOB_PYR" />
											</xsl:with-param>
										</xsl:call-template>
									</BirthDate>
								</Person>
							</xsl:if>
							<Address id="PYR">
								<xsl:if test="(./instanceData/TXLife/A_PayorType) = '100'">
									<AddressTypeCode tc="1">Home</AddressTypeCode>
								</xsl:if>
								<xsl:if test="(./instanceData/TXLife/A_PayorType) != '100'">
									<AddressTypeCode tc="2">Business</AddressTypeCode>
								</xsl:if>
								<AttentionLine>
									<xsl:value-of select="instanceData/TXLife/A_AddressLine1_PYR" />
								</AttentionLine>
								<Line1>
									<xsl:value-of select="instanceData/TXLife/A_AddressLine2_PYR" />
								</Line1>
								<Line2>
									<xsl:value-of select="instanceData/TXLife/A_AddressLine3_PYR" />
								</Line2>
								<Line3>
									<xsl:value-of select="instanceData/TXLife/A_AddressLine4_PYR" />
								</Line3>
								<City>
									<xsl:value-of select="instanceData/TXLife/A_City_PYR" />
								</City>
								<AddressStateTC>
									<xsl:attribute name="tc">
											<xsl:value-of select="instanceData/TXLife/A_State_PYR" />
										</xsl:attribute>
									<xsl:value-of select="instanceData/TXLife/A_State_PYR_Desc" />
								</AddressStateTC>
								<xsl:choose>
									<xsl:when test="contains(instanceData/TXLife/A_ZipCode_PYR ,'-')">
										<Zip>
											<xsl:value-of
												select="translate(instanceData/TXLife/A_ZipCode_PYR,'-','')" />
										</Zip>
									</xsl:when>
									<xsl:when
										test="not(contains(instanceData/TXLife/A_ZipCode_PYR ,'-'))">
										<Zip>
											<xsl:value-of select="instanceData/TXLife/A_ZipCode_PYR" />
										</Zip>
									</xsl:when>
								</xsl:choose>
							</Address>
							<xsl:if
								test="string-length(./instanceData/TXLife/A_PhoneNum_PYR)  >  0">
								<Phone id="Phone1_PYR">
									<xsl:if test="(./instanceData/TXLife/A_PayorType) = '100'">
										<PhoneTypeCode tc="1">Home</PhoneTypeCode>
									</xsl:if>
									<xsl:if test="(./instanceData/TXLife/A_PayorType) != '100'">
										<PhoneTypeCode tc="2">Business</PhoneTypeCode>
									</xsl:if>
									<AreaCode>
										<xsl:value-of
											select="substring(./instanceData/TXLife/A_PhoneNum_PYR,1,3)" />
									</AreaCode>
									<DialNumber>
										<xsl:value-of
											select="substring(./instanceData/TXLife/A_PhoneNum_PYR,4)" />
									</DialNumber>
								</Phone>
							</xsl:if>
						</Party>
					</xsl:if>
					<!-- Authorized person For Entity Payor -->
					<xsl:if
						test="(./instanceData/TXLife/A_PayorType) !='-1' and (./instanceData/TXLife/A_PremPayor) ='3' and 
						(string-length(./instanceData/TXLife/A_EntityName_PYR))  >  0 or
						(string-length(./instanceData/TXLife/A_ContactFirstName_PYR))  >  0 or
						(string-length(./instanceData/TXLife/A_ContactLastName_PYR))  >  0">
						<Party id="Party_PYR_AUTHORIZED">
							<PartyTypeCode tc="1">Person</PartyTypeCode>
							<Person>
								<FirstName>
									<xsl:value-of select="instanceData/TXLife/A_ContactFirstName_PYR" />
								</FirstName>
								<xsl:if
									test="string-length(./instanceData/TXLife/A_ContactMiddleName_PYR) > 0">
									<MiddleName>
										<xsl:value-of select="instanceData/TXLife/A_ContactMiddleName_PYR" />
									</MiddleName>
								</xsl:if>
								<LastName>
									<xsl:value-of select="instanceData/TXLife/A_ContactLastName_PYR" />
								</LastName>
								<xsl:if test="./instanceData/TXLife/A_ContactPrefix_PYR != '-1'">
									<Prefix>
										<xsl:value-of select="instanceData/TXLife/A_ContactPrefix_PYR" />
									</Prefix>
								</xsl:if>
								<xsl:if test="./instanceData/TXLife/A_ContactSuffix_PYR != '-1'">
									<Suffix>
										<xsl:value-of select="instanceData/TXLife/A_ContactSuffix_PYR" />
									</Suffix>
								</xsl:if>
							</Person>
						</Party>
					</xsl:if>
					<!-- Notices Party -->
					<xsl:if
						test="./instanceData/TXLife/A_AddNoticesInd  = '1' and (string-length(./instanceData/TXLife/A_FirstName_TPN1)>0 
						or string-length(./instanceData/TXLife/A_LastName_TPN1)>0)">
						<Party id="Party_3rdPartyNotif">
							<PartyTypeCode tc="1">Person</PartyTypeCode>
							<Person>
								<FirstName>
									<xsl:value-of select="instanceData/TXLife/A_FirstName_TPN1" />
								</FirstName>
								<xsl:if
									test="string-length(./instanceData/TXLife/A_MiddleName_TPN1) > 0">
									<MiddleName>
										<xsl:value-of select="instanceData/TXLife/A_MiddleName_TPN1" />
									</MiddleName>
								</xsl:if>
								<LastName>
									<xsl:value-of select="instanceData/TXLife/A_LastName_TPN1" />
								</LastName>
								<xsl:if test="./instanceData/TXLife/A_Prefix_TPN1 != '-1'">
									<Prefix>
										<xsl:value-of select="instanceData/TXLife/A_Prefix_TPN1" />
									</Prefix>
								</xsl:if>
								<xsl:if test="./instanceData/TXLife/A_Suffix_TPN1 != '-1'">
									<Suffix>
										<xsl:value-of select="instanceData/TXLife/A_Suffix_TPN1" />
									</Suffix>
								</xsl:if>
							</Person>
							<Address id="Address_3rdPartyNotif">
								<AddressTypeCode tc="1">Home</AddressTypeCode>
								<AttentionLine>
									<xsl:value-of select="instanceData/TXLife/A_AddressLine1_TPN1" />
								</AttentionLine>
								<Line1>
									<xsl:value-of select="instanceData/TXLife/A_AddressLine1_TPN1" />
								</Line1>
								<Line2>
									<xsl:value-of select="instanceData/TXLife/A_AddressLine2_TPN1" />
								</Line2>
								<Line3>
									<xsl:value-of select="instanceData/TXLife/A_AddressLine3_TPN1" />
								</Line3>
								<City>
									<xsl:value-of select="instanceData/TXLife/A_City_TPN1" />
								</City>
								<AddressStateTC>
									<xsl:attribute name="tc">
											<xsl:value-of select="instanceData/TXLife/A_State_TPN1" />
										</xsl:attribute>
									<xsl:value-of select="instanceData/TXLife/A_State_TPN1_Desc" />
								</AddressStateTC>
								<xsl:choose>
									<xsl:when test="contains(instanceData/TXLife/A_Zip_TPN1 ,'-')">
										<Zip>
											<xsl:value-of
												select="translate(instanceData/TXLife/A_Zip_TPN1,'-','')" />
										</Zip>
									</xsl:when>
									<xsl:when test="not(contains(instanceData/TXLife/A_Zip_TPN1 ,'-'))">
										<Zip>
											<xsl:value-of select="instanceData/TXLife/A_Zip_TPN1" />
										</Zip>
									</xsl:when>
								</xsl:choose>
							</Address>
						</Party>
					</xsl:if>
					<!-- CasePreference Party -->
					<xsl:if
						test="string-length(./instanceData/TXLife/A_FirstName_CMGR)  >  0 or string-length(./instanceData/TXLife/A_LastName_CMGR)  >  0">
						<Party id="Party_CaseContact">
							<PartyTypeCode tc="1">Person</PartyTypeCode>
							<Person>
								<FirstName>
									<xsl:value-of select="instanceData/TXLife/A_FirstName_CMGR" />
								</FirstName>
								<xsl:if
									test="string-length(./instanceData/TXLife/A_MiddleName_CMGR) > 0">
									<MiddleName>
										<xsl:value-of select="instanceData/TXLife/A_MiddleName_CMGR" />
									</MiddleName>
								</xsl:if>
								<LastName>
									<xsl:value-of select="instanceData/TXLife/A_LastName_CMGR" />
								</LastName>
								<xsl:if test="./instanceData/TXLife/A_Prefix_CMGR != '-1'">
									<Prefix>
										<xsl:value-of select="instanceData/TXLife/A_Prefix_CMGR" />
									</Prefix>
								</xsl:if>
								<xsl:if test="./instanceData/TXLife/A_Suffix_CMGR != '-1'">
									<Suffix>
										<xsl:value-of select="instanceData/TXLife/A_Suffix_CMGR" />
									</Suffix>
								</xsl:if>
							</Person>
							<xsl:if test="string-length(./instanceData/TXLife/A_Phone_CMGR)>  0">
								<Phone id="Phone1_CaseContact">
									<PhoneTypeCode tc="2">Business</PhoneTypeCode>
									<AreaCode>
										<xsl:value-of
											select="substring(./instanceData/TXLife/A_Phone_CMGR,1,3)" />
									</AreaCode>
									<DialNumber>
										<xsl:value-of
											select="substring(./instanceData/TXLife/A_Phone_CMGR,4)" />
									</DialNumber>
								</Phone>
							</xsl:if>
							<xsl:if
								test="string-length(./instanceData/TXLife/A_EmailAddress_CMGR)	>  0">
								<EMailAddress id="EmailAddress_CMGR">
									<EMailType tc="1">Business</EMailType>
									<AddrLine>
										<xsl:value-of select="instanceData/TXLife/A_EmailAddress_CMGR" />
									</AddrLine>
								</EMailAddress>
							</xsl:if>
						</Party>
					</xsl:if>
					<!-- BEN Party START -->
					<xsl:for-each select="instanceData/TXLife/*">
						<xsl:if test="starts-with(name(),'A_BeneficiaryType_BEN')">
							<xsl:if test="string-length(.) > 0">
								<xsl:variable name="pos" select="substring(name(),22)" />
								<xsl:variable name="benValue"
									select='format-number(../*[name()="A_COUNT_TOTAL_BEN"], "0")' />
								<xsl:variable name="posValue" select='format-number($pos, "0")' />
								<xsl:if test="$pos != '' and $posValue &lt;= $benValue">
									<xsl:if
										test="string-length(../*[name()=concat('A_FirstName_BEN',$pos)])> 0 or string-length(../*[name()=concat('A_LastName_BEN',$pos)])> 0 or string-length(../*[name()=concat('A_EntityName_BEN',$pos)])> 0 ">
										<Party>
											<xsl:attribute name="id">
												<xsl:value-of select="concat('Party_BEN',$pos)" />
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
												<xsl:value-of select="../*[name()=concat('A_EntityName_BEN',$pos)]" />
											</FullName>
											<xsl:if
												test="../*[name()=concat('A_BeneficiaryType_BEN',$pos)] = '1'">
												<xsl:if
													test="string-length(../*[name()=concat('A_GovtID_BEN',$pos)])	>  0">
													<GovtID>
														<xsl:value-of
															select="translate(../*[name()=concat('A_GovtID_BEN',$pos)],'-','')" />
													</GovtID>
													<GovtIDTC tc="1">Social Security Number</GovtIDTC>
												</xsl:if>
											</xsl:if>
											<xsl:if
												test="../*[name()=concat('A_BeneficiaryType_BEN',$pos)] = '2'">
												<xsl:if
													test="string-length(../*[name()=concat('A_GovtID_BEN',$pos)])	>  0">
													<GovtID>
														<xsl:value-of
															select="translate(../*[name()=concat('A_GovtID_BEN',$pos)],'-','')" />
													</GovtID>
													<GovtIDTC tc="2">Taxpayer Identification Number
													</GovtIDTC>
												</xsl:if>
											</xsl:if>
											<Person>
												<FirstName>
													<xsl:value-of select="../*[name()=concat('A_FirstName_BEN',$pos)]" />
												</FirstName>
												<xsl:if
													test="string-length(../*[name()=concat('A_MiddleName_BEN',$pos)])	>  0">
													<MiddleName>
														<xsl:value-of
															select="../*[name()=concat('A_MiddleName_BEN',$pos)]" />
													</MiddleName>
												</xsl:if>
												<LastName>
													<xsl:value-of select="../*[name()=concat('A_LastName_BEN',$pos)]" />
												</LastName>
												<xsl:if test="../*[name()=concat('A_Prefix_BEN',$pos)] != '-1'">
													<Prefix>
														<xsl:value-of select="../*[name()=concat('A_Prefix_BEN',$pos)]" />
													</Prefix>
												</xsl:if>
												<xsl:if test="../*[name()=concat('A_Suffix_BEN',$pos)] != '-1'">
													<Suffix>
														<xsl:value-of select="../*[name()=concat('A_Suffix_BEN',$pos)]" />
													</Suffix>
												</xsl:if>
												<xsl:if
													test="string-length(../*[name()=concat('A_DOB_BEN',$pos)])	>  0">
													<BirthDate>
														<xsl:value-of select="../*[name()=concat('A_DOB_BEN',$pos)]" />
													</BirthDate>
												</xsl:if>
											</Person>
											<Organization>
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
												 string-length(../*[name()=concat('A_ZipCode_BEN',$pos)]) > 0">
												<Address>
													<xsl:attribute name="id">
													<xsl:value-of select="concat('Address_BEN',$pos)" />
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
													<xsl:if
														test="string-length(../*[name()=concat('A_AddressLine1_BEN',$pos)]) > 0">
														<AttentionLine>
															<xsl:value-of
																select="../*[name()=concat('A_AddressLine1_BEN',$pos)]" />
														</AttentionLine>
													</xsl:if>
													<xsl:if
														test="string-length(../*[name()=concat('A_AddressLine2_BEN',$pos)]) > 0">
														<Line1>
															<xsl:value-of
																select="../*[name()=concat('A_AddressLine2_BEN',$pos)]" />
														</Line1>
													</xsl:if>
													<xsl:if
														test="string-length(../*[name()=concat('A_AddressLine3_BEN',$pos)]) > 0">
														<Line2>
															<xsl:value-of
																select="../*[name()=concat('A_AddressLine3_BEN',$pos)]" />
														</Line2>
													</xsl:if>
													<xsl:if
														test="string-length(../*[name()=concat('A_AddressLine4_BEN',$pos)]) > 0">
														<Line3>
															<xsl:value-of
																select="../*[name()=concat('A_AddressLine4_BEN',$pos)]" />
														</Line3>
													</xsl:if>
													<xsl:if
														test="string-length(../*[name()=concat('A_City_BEN',$pos)]) > 0">
														<City>
															<xsl:value-of select="../*[name()=concat('A_City_BEN',$pos)]" />
														</City>
													</xsl:if>
													<xsl:if test="(../*[name()=concat('A_State_BEN',$pos)]) != '-1'">
														<AddressStateTC>
															<xsl:attribute name="tc">
															<xsl:value-of select="../*[name()=concat('A_State_BEN',$pos)]" />
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
												</Address>
											</xsl:if>
											<xsl:if
												test="string-length(../*[name()=concat('A_PhoneNum_BEN',$pos)])>0">
												<Phone>
													<xsl:attribute name="id">
															<xsl:value-of select="concat('Phone_BEN_',$pos)" />
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
									<xsl:variable name="pos" select="substring(name(),22)" />
									<xsl:variable name="benValue"
										select='format-number(../*[name()="A_COUNT_TOTAL_CBN"], "0")' />
									<xsl:variable name="posValue" select='format-number($pos, "0")' />
									<xsl:if test="$pos != '' and $posValue &lt;= $benValue">
										<xsl:if
											test="string-length(../*[name()=concat('A_FirstName_CBN',$pos)])> 0 or string-length(../*[name()=concat('A_LastName_CBN',$pos)])> 0 or string-length(../*[name()=concat('A_EntityName_CBN',$pos)])> 0 ">
											<Party>
												<xsl:attribute name="id">
													<xsl:value-of select="concat('Party_CBN',$pos)" />
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
														test="string-length(../*[name()=concat('A_GovtID_CBN',$pos)])	>  0">
														<GovtID>
															<xsl:value-of
																select="translate(../*[name()=concat('A_GovtID_CBN',$pos)],'-','')" />
														</GovtID>
														<GovtIDTC tc="1">Social Security Number</GovtIDTC>
													</xsl:if>
												</xsl:if>
												<xsl:if
													test="../*[name()=concat('A_BeneficiaryType_CBN',$pos)] = '2'">
													<xsl:if
														test="string-length(../*[name()=concat('A_GovtID_CBN',$pos)])	>  0">
														<GovtID>
															<xsl:value-of
																select="translate(../*[name()=concat('A_GovtID_CBN',$pos)],'-','')" />
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
													<xsl:if
														test="string-length(../*[name()=concat('A_MiddleName_CBN',$pos)])	>  0">
														<MiddleName>
															<xsl:value-of
																select="../*[name()=concat('A_MiddleName_CBN',$pos)]" />
														</MiddleName>
													</xsl:if>
													<LastName>
														<xsl:value-of select="../*[name()=concat('A_LastName_CBN',$pos)]" />
													</LastName>
													<xsl:if test="../*[name()=concat('A_Prefix_CBN',$pos)] != '-1'">
														<Prefix>
															<xsl:value-of select="../*[name()=concat('A_Prefix_CBN',$pos)]" />
														</Prefix>
													</xsl:if>
													<xsl:if test="../*[name()=concat('A_Suffix_CBN',$pos)] != '-1'">
														<Suffix>
															<xsl:value-of select="../*[name()=concat('A_Suffix_CBN',$pos)]" />
														</Suffix>
													</xsl:if>
													<xsl:if
														test="string-length(../*[name()=concat('A_DOB_CBN',$pos)])	>  0">
														<BirthDate>
															<xsl:value-of select="../*[name()=concat('A_DOB_CBN',$pos)]" />
														</BirthDate>
													</xsl:if>
												</Person>
												<Organization>
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
												 string-length(../*[name()=concat('A_ZipCode_CBN',$pos)]) > 0">
													<Address>
														<xsl:attribute name="id">
														<xsl:value-of select="concat('Address_CBN',$pos)" />
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
															<AttentionLine>
																<xsl:value-of
																	select="../*[name()=concat('A_AddressLine1_CBN',$pos)]" />
															</AttentionLine>
														</xsl:if>
														<xsl:if
															test="string-length(../*[name()=concat('A_AddressLine2_CBN',$pos)]) > 0">
															<Line1>
																<xsl:value-of
																	select="../*[name()=concat('A_AddressLine2_CBN',$pos)]" />
															</Line1>
														</xsl:if>
														<xsl:if
															test="string-length(../*[name()=concat('A_AddressLine3_CBN',$pos)]) > 0">
															<Line2>
																<xsl:value-of
																	select="../*[name()=concat('A_AddressLine3_CBN',$pos)]" />
															</Line2>
														</xsl:if>
														<xsl:if
															test="string-length(../*[name()=concat('A_AddressLine4_CBN',$pos)]) > 0">
															<Line3>
																<xsl:value-of
																	select="../*[name()=concat('A_AddressLine4_CBN',$pos)]" />
															</Line3>
														</xsl:if>
														<xsl:if
															test="string-length(../*[name()=concat('A_City_CBN',$pos)]) > 0">
															<City>
																<xsl:value-of select="../*[name()=concat('A_City_CBN',$pos)]" />
															</City>
														</xsl:if>
														<xsl:if
															test="(../*[name()=concat('A_State_CBN',$pos)]) != '-1'">
															<AddressStateTC>
																<xsl:attribute name="tc">
																<xsl:value-of select="../*[name()=concat('A_State_CBN',$pos)]" />
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
													</Address>
												</xsl:if>
												<xsl:if
													test="string-length(../*[name()=concat('A_PhoneNum_CBN',$pos)])>0">
													<Phone>
														<xsl:attribute name="id">
															<xsl:value-of select="concat('Phone_CBN_',$pos)" />
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
					<!-- Personal Physician Party -->
					<xsl:if
						test="./instanceData/TXLife/A_PersonalPhysicanCB_PINS = 1 and (string-length(./instanceData/TXLife/A_FirstName_PPHY)>0 or
					string-length(./instanceData/TXLife/A_LastName_PPHY)>0 or string-length(./instanceData/TXLife/A_ClinicName_PPHY)>0)">
						<Party id="Party_Insured_Physician">
							<xsl:if test="./instanceData/TXLife/A_PhysicanType_PPHY = '0'">
								<PartyTypeCode tc="1">Physician</PartyTypeCode>
							</xsl:if>
							<xsl:if test="./instanceData/TXLife/A_PhysicanType_PPHY = '1'">
								<PartyTypeCode tc="2">Medical Facility</PartyTypeCode>
							</xsl:if>
							<xsl:if
								test="string-length(./instanceData/TXLife/A_ClinicName_PPHY) > 0">
								<FullName>
									<xsl:value-of select="instanceData/TXLife/A_ClinicName_PPHY" />
								</FullName>
							</xsl:if>
							<xsl:if test="./instanceData/TXLife/A_PhysicanType_PPHY = '0'">
								<Person>
									<FirstName>
										<xsl:value-of select="instanceData/TXLife/A_FirstName_PPHY" />
									</FirstName>
									<xsl:if
										test="string-length(./instanceData/TXLife/A_MiddleName_PPHY) > 0">
										<MiddleName>
											<xsl:value-of select="instanceData/TXLife/A_MiddleName_PPHY" />
										</MiddleName>
									</xsl:if>
									<LastName>
										<xsl:value-of select="instanceData/TXLife/A_LastName_PPHY" />
									</LastName>
									<xsl:if test="./instanceData/TXLife/A_Prefix_PPHY != '-1'">
										<Prefix>
											<xsl:value-of select="instanceData/TXLife/A_Prefix_PPHY" />
										</Prefix>
									</xsl:if>
									<xsl:if test="./instanceData/TXLife/A_Suffix_PPHY != '-1'">
										<Suffix>
											<xsl:value-of select="instanceData/TXLife/A_Suffix_PPHY" />
										</Suffix>
									</xsl:if>
								</Person>
							</xsl:if>
							<!-- Updated by Puja.. corrected the attribute name -->
							<xsl:if test="./instanceData/TXLife/A_PhysicanType_PPHY = '1'">
								<Organization>
									<DBA>
										<xsl:value-of select="instanceData/TXLife/A_ClinicName_PPHY" />
									</DBA>
								</Organization>
							</xsl:if>
							<xsl:if
								test="string-length(./instanceData/TXLife/A_AddressLine1_PPHY) > 0 or string-length(./instanceData/TXLife/A_City_PPHY) > 0 or string-length(./instanceData/TXLife/A_State_PPHY_Desc) > 0 or string-length(./instanceData/TXLife/A_ZipCode_PPHY) > 0">
								<Address id="Address_Insured_Physician">
									<AddressTypeCode tc="2">Business</AddressTypeCode>
									<AttentionLine>
										<xsl:value-of select="instanceData/TXLife/A_AddressLine1_PPHY" />
									</AttentionLine>
									<Line1>
										<xsl:value-of select="instanceData/TXLife/A_AddressLine2_PPHY" />
									</Line1>
									<Line2>
										<xsl:value-of select="instanceData/TXLife/A_AddressLine3_PPHY" />
									</Line2>
									<Line3>
										<xsl:value-of select="instanceData/TXLife/A_AddressLine4_PPHY" />
									</Line3>
									<City>
										<xsl:value-of select="instanceData/TXLife/A_City_PPHY" />
									</City>
									<AddressStateTC>
										<xsl:attribute name="tc">
												<xsl:value-of select="instanceData/TXLife/A_State_PPHY" />
											</xsl:attribute>
										<xsl:value-of select="instanceData/TXLife/A_State_PPHY_Desc" />
									</AddressStateTC>
									<xsl:choose>
										<xsl:when test="contains(instanceData/TXLife/A_ZipCode_PPHY ,'-')">
											<Zip>
												<xsl:value-of
													select="translate(instanceData/TXLife/A_ZipCode_PPHY,'-','')" />
											</Zip>
										</xsl:when>
										<xsl:when
											test="not(contains(instanceData/TXLife/A_ZipCode_PPHY ,'-'))">
											<Zip>
												<xsl:value-of select="instanceData/TXLife/A_ZipCode_PPHY" />
											</Zip>
										</xsl:when>
									</xsl:choose>
								</Address>
							</xsl:if>
							<xsl:if
								test="string-length(./instanceData/TXLife/A_PhoneNo_PPHY)  >  0">
								<Phone id="Phone1_Insured_Physician">
									<PhoneTypeCode tc="2">Business</PhoneTypeCode>
									<AreaCode>
										<xsl:value-of
											select="substring(./instanceData/TXLife/A_PhoneNo_PPHY,1,3)" />
									</AreaCode>
									<DialNumber>
										<xsl:value-of
											select="substring(./instanceData/TXLife/A_PhoneNo_PPHY,4)" />
									</DialNumber>
								</Phone>
							</xsl:if>
							<!-- BHFD-531 -->
							<Physician>
								<OLifEExtension ExtensionCode="Physician 2.8.90"
									VendorCode="05">
									<PhysicianExtension>
										<xsl:if
											test="string-length(./instanceData/TXLife/A_LastConsultDate_PPHY)	>  0">
											<DateLastSeen>
												<xsl:call-template name="FormatDate">
													<xsl:with-param name="Separator">
														/
													</xsl:with-param>
													<xsl:with-param name="DateString">
														<xsl:value-of select="instanceData/TXLife/A_LastConsultDate_PPHY" />
													</xsl:with-param>
												</xsl:call-template>
											</DateLastSeen>
										</xsl:if>
									</PhysicianExtension>
								</OLifEExtension>
							</Physician>
						</Party>
					</xsl:if>
					<!-- Additional Physician/Facility Party PINS -->
					<xsl:if test="./instanceData/TXLife/A_PhysicanCB_PINS='1'">
						<xsl:for-each select="instanceData/TXLife/*">
							<xsl:if test="starts-with(name(),'A_PhysicanType_PHY')">
								<xsl:if test="string-length(.) > 0">
									<xsl:variable name="pos" select="substring(name(),19)" />
									<xsl:variable name="benValue"
										select='format-number(../*[name()="A_COUNT_TOTAL_PHY"], "0")' />
									<xsl:variable name="posValue" select='format-number($pos, "0")' />
									<xsl:if test="$pos != '' and $posValue &lt;= $benValue">
										<xsl:if
											test="../*[name()=concat('A_PhysicanType_PHY',$pos)]!='-1' and (
											string-length(../*[name()=concat('A_FirstName_PHY',$pos)])>0 or
											string-length(../*[name()=concat('A_LastName_PHY',$pos)])>0 or
											string-length(../*[name()=concat('A_ClinicName_PHY',$pos)])>0)">
											<Party>
												<xsl:attribute name="id">
														<xsl:value-of select="concat('Party_41_',$pos)" />
													</xsl:attribute>
												<xsl:if test="../*[name()=concat('A_PhysicanType_PHY',$pos)]='0'">
													<PartyTypeCode tc="1">Physician</PartyTypeCode>
													<Person>
														<FirstName>
															<xsl:value-of
																select="../*[name()=concat('A_FirstName_PHY',$pos)]" />
														</FirstName>
														<xsl:if
															test="string-length(../*[name()=concat('A_MiddleName_PHY',$pos)])>0">
															<MiddleName>
																<xsl:value-of
																	select="../*[name()=concat('A_MiddleName_PHY',$pos)]" />
															</MiddleName>
														</xsl:if>
														<LastName>
															<xsl:value-of
																select="../*[name()=concat('A_LastName_PHY',$pos)]" />
														</LastName>
														<xsl:if test="../*[name()=concat('A_Prefix_PHY',$pos)] != '-1'">
															<Prefix>
																<xsl:value-of select="../*[name()=concat('A_Prefix_PHY',$pos)]" />
															</Prefix>
														</xsl:if>
														<xsl:if test="../*[name()=concat('A_Suffix_PHY',$pos)] != '-1'">
															<Suffix>
																<xsl:value-of select="../*[name()=concat('A_Suffix_PHY',$pos)]" />
															</Suffix>
														</xsl:if>
													</Person>
												</xsl:if>
												<xsl:if test="../*[name()=concat('A_PhysicanType_PHY',$pos)]='1'">
													<PartyTypeCode tc="2">Medical Facility
													</PartyTypeCode>
													<FullName>
														<xsl:value-of
															select="../*[name()=concat('A_ClinicName_PHY',$pos)]" />
													</FullName>
													<Organization>
														<DBA>
															<xsl:value-of
																select="../*[name()=concat('A_ClinicName_PHY',$pos)]" />
														</DBA>
													</Organization>
												</xsl:if>
												<xsl:if
													test="string-length(../*[name()=concat('A_AddressLine1_PHY',$pos)])>0 or string-length(../*[name()=concat('A_City_PHY',$pos)])>0 or 	string-length(../*[name()=concat('A_State_PHY',$pos)])>0 or string-length(../*[name()=concat('A_ZipCode_PHY',$pos)])>0 ">
													<Address>
														<xsl:attribute name="id">
																	<xsl:value-of select="concat('Address_41_',$pos)" />
																</xsl:attribute>
														<AddressTypeCode tc="2">Business
														</AddressTypeCode>
														<AttentionLine>
															<xsl:value-of
																select="../*[name()=concat('A_AddressLine1_PHY',$pos)]" />
														</AttentionLine>
														<Line1>
															<xsl:value-of
																select="../*[name()=concat('A_AddressLine2_PHY',$pos)]" />
														</Line1>
														<Line2>
															<xsl:value-of
																select="../*[name()=concat('A_AddressLine3_PHY',$pos)]" />
														</Line2>
														<Line3>
															<xsl:value-of
																select="../*[name()=concat('A_AddressLine4_PHY',$pos)]" />
														</Line3>
														<City>
															<xsl:value-of select="../*[name()=concat('A_City_PHY',$pos)]" />
														</City>
														<AddressStateTC>
															<xsl:attribute name="tc">
																		<xsl:value-of
																select="../*[name()=concat('A_State_PHY',$pos)]" />
																	</xsl:attribute>
															<xsl:value-of
																select="../*[name()=concat('A_State_PHY',$pos, '_Desc')]" />
														</AddressStateTC>
														<xsl:choose>
															<xsl:when
																test="contains(../*[name()=concat('A_ZipCode_PHY',$pos)] ,'-')">
																<Zip>
																	<xsl:value-of
																		select="translate(../*[name()=concat('A_ZipCode_PHY',$pos)],'-','')" />
																</Zip>
															</xsl:when>
															<xsl:when
																test="not(contains(../*[name()=concat('A_ZipCode_PHY',$pos)] ,'-'))">
																<Zip>
																	<xsl:value-of
																		select="../*[name()=concat('A_ZipCode_PHY',$pos)]" />
																</Zip>
															</xsl:when>
														</xsl:choose>
													</Address>
												</xsl:if>
												<xsl:if
													test="string-length(../*[name()=concat('A_PhoneNo_PHY',$pos)])>0">
													<Phone>
														<xsl:attribute name="id">
																	<xsl:value-of select="concat('Phone1_41_',$pos)" />
																</xsl:attribute>
														<PhoneTypeCode tc="2">Business</PhoneTypeCode>
														<AreaCode>
															<xsl:value-of
																select="substring(../*[name()=concat('A_PhoneNo_PHY',$pos)],1,3)" />
														</AreaCode>
														<DialNumber>
															<xsl:value-of
																select="substring(../*[name()=concat('A_PhoneNo_PHY',$pos)],4)" />
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
					<!-- Employer Party START -->
					<xsl:if test="string-length(instanceData/TXLife/A_EmployerName_PINS)>0">
						<Party id="Party_EMPLOYER">
							<PartyTypeCode tc="2">Organization</PartyTypeCode>
							<Organization>
								<DBA>
									<xsl:value-of select="instanceData/TXLife/A_EmployerName_PINS" />
								</DBA>
							</Organization>
						</Party>
					</xsl:if>
					<!-- Employer Party END -->
					<!-- Employer Party Relation START -->
					<xsl:if test="string-length(instanceData/TXLife/A_EmployerName_PINS)>0">
						<Relation id="Relation_EMPLOYER" OriginatingObjectID="Party_PINS"
							RelatedObjectID="Party_EMPLOYER">
							<OriginatingObjectType tc="6">Party
							</OriginatingObjectType>
							<RelatedObjectType tc="6">Party</RelatedObjectType>
							<RelationRoleCode tc="7">EMPLOYER</RelationRoleCode>
						</Relation>
					</xsl:if>
					<!-- Employer Party Relation END -->
					<!-- Notices Party Relation -->
					<xsl:if
						test="./instanceData/TXLife/A_AddNoticesInd  = '1' and (string-length(./instanceData/TXLife/A_FirstName_TPN1)>0 
						or string-length(./instanceData/TXLife/A_LastName_TPN1))>0">
						<Relation id="Relation_3rdPartyNotif"
							OriginatingObjectID="Holding_1" RelatedObjectID="Party_3rdPartyNotif">
							<OriginatingObjectType tc="4">Holding
							</OriginatingObjectType>
							<RelatedObjectType tc="6">Party</RelatedObjectType>
							<!-- Updated by Puja, tc value updated -->
							<RelationRoleCode tc="123">Third Party
							</RelationRoleCode>
						</Relation>
					</xsl:if>
					<!-- Replacment relation holding/holding -->
					<xsl:for-each select="instanceData/TXLife/*">
						<xsl:if test="starts-with(name(),'A_InsuranceAmount_REP')">
							<xsl:variable name="pos" select="substring(name(),22)" />
							<xsl:variable name="repCount"
								select='format-number(../*[name()="A_COUNT_TOTAL_REP"], "0")' />
							<xsl:variable name="posValue" select='format-number($pos, "0")' />
							<xsl:if test="$pos != '' and $posValue &lt;= $repCount">
								<xsl:if
									test=" string-length(../*[name()=concat('A_ReplacementInd_REP',$pos)])> 0
										and string-length(../*[name()=concat('A_ReplacementCompany_REP',$pos)])>0 and
											../*[name()=concat('A_ReplacementCompany_REP',$pos)]!='-1'">
									<Relation OriginatingObjectID="Holding_1">
										<xsl:attribute name="RelatedObjectID">
															<xsl:value-of select="concat('Holding_REP_',$pos)" />
														</xsl:attribute>
										<xsl:attribute name="id">
															<xsl:value-of select="concat('Relation_REP',$pos,'_2')" />
														</xsl:attribute>
										<OriginatingObjectType tc="4">Holding
										</OriginatingObjectType>
										<RelatedObjectType tc="4">Holding
										</RelatedObjectType>
										<xsl:if test="../*[name()=concat('A_ReplacementInd_REP',$pos)]='1'">
											<RelationRoleCode tc="64">Replaced by
											</RelationRoleCode>
										</xsl:if>
										<!-- RelationRoleCode to be confirmed by Puja -->
										<xsl:if test="../*[name()=concat('A_ReplacementInd_REP',$pos)]='0'">
											<RelationRoleCode tc="124">Existing Insurance
											</RelationRoleCode>
										</xsl:if>
									</Relation>
								</xsl:if>
							</xsl:if>
						</xsl:if>
					</xsl:for-each>
					<!-- Carrier party and the holding for the existing relation -->
					<xsl:for-each select="instanceData/TXLife/*">
						<xsl:if test="starts-with(name(),'A_InsuranceAmount_REP')">
							<xsl:if test="string-length(.) > 0">
								<xsl:variable name="pos" select="substring(name(),22)" />
								<xsl:variable name="repCount"
									select='format-number(../*[name()="A_COUNT_TOTAL_REP"], "0")' />
								<xsl:variable name="posValue" select='format-number($pos, "0")' />
								<xsl:if test="$pos != '' and $posValue &lt;= $repCount">
									<Relation>
										<xsl:attribute name="RelatedObjectID">
														<xsl:value-of select="concat('Party_REP',$pos,'_CAR')" />
													</xsl:attribute>
										<xsl:attribute name="OriginatingObjectID">
														<xsl:value-of select="concat('Holding_REP_',$pos)" />
													</xsl:attribute>
										<xsl:attribute name="id">
														<xsl:value-of select="concat('Relation_REP',$pos,'_1')" />
													</xsl:attribute>
										<OriginatingObjectType tc="4">Holding
										</OriginatingObjectType>
										<RelatedObjectType tc="6">Party
										</RelatedObjectType>
										<RelationRoleCode tc="88">Holding Company
										</RelationRoleCode>
									</Relation>
								</xsl:if>
							</xsl:if>
						</xsl:if>
					</xsl:for-each>
					<xsl:for-each select="instanceData/TXLife/*">
						<xsl:if test="starts-with(name(),'A_InsuranceAmount_REP')">
							<xsl:if test="string-length(.) > 0">
								<xsl:variable name="pos" select="substring(name(),22)" />
								<xsl:variable name="repCount"
									select='format-number(../*[name()="A_COUNT_TOTAL_REP"], "0")' />
								<xsl:variable name="posValue" select='format-number($pos, "0")' />
								<xsl:if test="$pos != '' and $posValue &lt;= $repCount">
									<xsl:if
										test="string-length(../*[name()=concat('A_LastName_REP',$pos)])>0">
										<Relation>
											<xsl:attribute name="RelatedObjectID">
															<xsl:value-of select="concat('Party_REP',$pos,'_INS')" />
														</xsl:attribute>
											<xsl:attribute name="OriginatingObjectID">
															<xsl:value-of select="concat('Holding_REP_',$pos)" />
														</xsl:attribute>
											<xsl:attribute name="id">
															<xsl:value-of select="concat('Relation_REP',$pos,'_3')" />
														</xsl:attribute>
											<OriginatingObjectType tc="4">Holding
											</OriginatingObjectType>
											<RelatedObjectType tc="6">Party
											</RelatedObjectType>
											<RelationRoleCode tc="32">Insured
											</RelationRoleCode>
											<RelationDescription tc="91">Self
											</RelationDescription>
										</Relation>
									</xsl:if>
								</xsl:if>
							</xsl:if>
						</xsl:if>
					</xsl:for-each>
					<!-- PINS Relation -->
					<Relation id="Relation_PINS" OriginatingObjectID="Holding_1"
						RelatedObjectID="Party_PINS">
						<OriginatingObjectType tc="4">Holding
						</OriginatingObjectType>
						<RelatedObjectType tc="6">Party</RelatedObjectType>
						<RelationRoleCode tc="32">Insured</RelationRoleCode>
						<RelationDescription tc="91">Self
						</RelationDescription>
					</Relation>
					<!-- CasePreference Party Relation -->
					<xsl:if
						test="string-length(./instanceData/TXLife/A_FirstName_CMGR)  >  0 or string-length(./instanceData/TXLife/A_LastName_CMGR)  >  0">
						<Relation id="Relation_CaseContact" OriginatingObjectID="Holding_1"
							RelatedObjectID="Party_CaseContact">
							<OriginatingObjectType tc="4">Holding
							</OriginatingObjectType>
							<RelatedObjectType tc="6">Party</RelatedObjectType>
							<RelationRoleCode tc="235">Case Contact
							</RelationRoleCode>
						</Relation>
					</xsl:if>
					<!-- Custodian Owner Party Relation -->
					<xsl:if test="string-length(./instanceData/TXLife/A_PIOtherThanOwn)= 1">
						<xsl:for-each select="instanceData/TXLife/*">
							<xsl:if test="starts-with(name(),'A_CustFirstName_OWN')">
								<xsl:if test="string-length(.) > 0">
									<xsl:variable name="pos" select="substring(name(),20)" />
									<xsl:variable name="agentValue"
										select='format-number(../*[name()="A_COUNT_TOTAL_OWN"], "0")' />
									<xsl:variable name="posValue" select='format-number($pos, "0")' />
									<xsl:if test="$pos != '' and $posValue &lt;= $agentValue">
										<xsl:if
											test="string-length(../*[name()=concat('A_CustFirstName_OWN',$pos)])>0 or string-length(../*[name()=concat('A_CustLastName_OWN',$pos)])>0">
											<Relation>
												<xsl:attribute name="id">
																<xsl:value-of select="concat('Relation_Custodian_OWN',$pos)" />
															</xsl:attribute>
												<xsl:attribute name="OriginatingObjectID">
												<!-- Deviated from requirement -->
																<xsl:value-of select="concat('Party_OWN',$pos)" />
															</xsl:attribute>
												<xsl:attribute name="RelatedObjectID">
																<xsl:value-of select="concat('Party_Custodian_OWN',$pos)" />
															</xsl:attribute>
												<OriginatingObjectType tc="6">Party
												</OriginatingObjectType>
												<RelatedObjectType tc="6">Party
												</RelatedObjectType>
												<RelationRoleCode tc="57">Custodian
												</RelationRoleCode>
												<RelationDescription>
													<xsl:attribute name="tc">
																<xsl:value-of
														select="../*[name()=concat('A_CustRelToMinor_OWN',$pos)]" />
																</xsl:attribute>
													<xsl:value-of
														select="../*[name()=concat('A_CustRelToMinor_OWN',$pos, '_Desc')]" />
												</RelationDescription>
											</Relation>
										</xsl:if>
									</xsl:if>
								</xsl:if>
							</xsl:if>
						</xsl:for-each>
					</xsl:if>
					<!-- Authorized Person Relation for Enitity Owner -->
					<xsl:if test="string-length(./instanceData/TXLife/A_PIOtherThanOwn)= 1">
						<xsl:for-each select="instanceData/TXLife/*">
							<xsl:if test="starts-with(name(),'A_FirstName_AUTHORIZED')">
								<xsl:if test="string-length(.) > 0">
									<xsl:variable name="pos" select="substring(name(),23)" />
									<xsl:variable name="agentValue"
										select='format-number(../*[name()="A_COUNT_TOTAL_OWN"], "0")' />
									<xsl:variable name="posValue" select='format-number($pos, "0")' />
									<xsl:if test="$pos != '' and $posValue &lt;= $agentValue">
										<xsl:if
											test="string-length(../*[name()=concat('A_FirstName_AUTHORIZED',$pos)])>0 or string-length(../*[name()=concat('A_LastName_AUTHORIZED',$pos)])>0">
											<Relation>
												<xsl:attribute name="id">
																<xsl:value-of select="concat('Relation_OWN_AUTHORIZED',$pos)" />
															</xsl:attribute>
												<xsl:attribute name="OriginatingObjectID">
																<xsl:value-of select="concat('Party_ENTITY',$pos)" />
															</xsl:attribute>
												<xsl:attribute name="RelatedObjectID">
																<xsl:value-of select="concat('Party_OWN_AUTHORIZED',$pos)" />
															</xsl:attribute>
												<OriginatingObjectType tc="6">Party
												</OriginatingObjectType>
												<RelatedObjectType tc="6">Party
												</RelatedObjectType>
												<xsl:if
													test="../*[name()=concat('A_OwnerTypeLife_OWN',$pos)]='2'">
													<RelationRoleCode tc="146">Business Partner
													</RelationRoleCode>
												</xsl:if>
												<xsl:if
													test="../*[name()=concat('A_OwnerTypeLife_OWN',$pos)]='1' or 
													../*[name()=concat('A_OwnerTypeLife_OWN',$pos)]='6'  or 
													../*[name()=concat('A_OwnerTypeLife_OWN',$pos)]='13' or 
													 ../*[name()=concat('A_OwnerTypeLife_OWN',$pos)]='11' or 
													 ../*[name()=concat('A_OwnerTypeLife_OWN',$pos)]='2147483647'  ">
													<RelationRoleCode tc="1009900003">Company Officer
													</RelationRoleCode>
												</xsl:if>
												<xsl:if
													test="../*[name()=concat('A_OwnerTypeLife_OWN',$pos)]='16'">
													<RelationRoleCode tc="69">Trustee
													</RelationRoleCode>
												</xsl:if>
											</Relation>
										</xsl:if>
									</xsl:if>
								</xsl:if>
							</xsl:if>
						</xsl:for-each>
					</xsl:if>
					<!-- physician party Relation -->
					<xsl:if test="./instanceData/TXLife/A_PhysicanCB_PINS='1'">
						<xsl:for-each select="instanceData/TXLife/*">
							<xsl:if test="starts-with(name(),'A_PhysicanType_PHY')">
								<xsl:if test="string-length(.) > 0">
									<xsl:variable name="pos" select="substring(name(),19)" />
									<xsl:variable name="benValue"
										select='format-number(../*[name()="A_COUNT_TOTAL_PHY"], "0")' />
									<xsl:variable name="posValue" select='format-number($pos, "0")' />
									<xsl:if test="$pos != '' and $posValue &lt;= $benValue">
										<xsl:if
											test="../*[name()=concat('A_PhysicanType_PHY',$pos)]!='-1' and (
											string-length(../*[name()=concat('A_FirstName_PHY',$pos)])>0 or
											string-length(../*[name()=concat('A_LastName_PHY',$pos)])>0 or
											string-length(../*[name()=concat('A_ClinicName_PHY',$pos)])>0)">
											<Relation OriginatingObjectID="Party_PINS">
												<xsl:attribute name="id">
																<xsl:value-of select="concat('Relation_41_',$pos)" />
															</xsl:attribute>
												<xsl:attribute name="RelatedObjectID">
																<xsl:value-of select="concat('Party_41_',$pos)" />
															</xsl:attribute>
												<OriginatingObjectType tc="6">Party
												</OriginatingObjectType>
												<RelatedObjectType tc="6">Party
												</RelatedObjectType>
												<RelationRoleCode tc="41"> Physician
												</RelationRoleCode>
											</Relation>
										</xsl:if>
									</xsl:if>
								</xsl:if>
							</xsl:if>
						</xsl:for-each>
					</xsl:if>
					<!-- Personal physician party Relation -->
					<xsl:if
						test="./instanceData/TXLife/A_PersonalPhysicanCB_PINS = 1 and (string-length(./instanceData/TXLife/A_FirstName_PPHY)>0 or
					string-length(./instanceData/TXLife/A_LastName_PPHY)>0 or string-length(./instanceData/TXLife/A_ClinicName_PPHY)>0)">
						<Relation id="Relation_Insured_Physician"
							OriginatingObjectID="Party_PINS" RelatedObjectID="Party_Insured_Physician">
							<OriginatingObjectType tc="6">Party
							</OriginatingObjectType>
							<RelatedObjectType tc="6">Party</RelatedObjectType>
							<RelationRoleCode tc="41">Physician
							</RelationRoleCode>
						</Relation>
					</xsl:if>
					<!-- Payor Relation -->
					<xsl:if
						test="(./instanceData/TXLife/A_PremPayor ='1' or ./instanceData/TXLife/A_PremPayor = '2' or ./instanceData/TXLife/A_PremPayor = '3') ">
						<Relation id="Relation_PAYOR" OriginatingObjectID="Holding_1">
							<xsl:if
								test="(./instanceData/TXLife/A_PremPayor !='-1' and ./instanceData/TXLife/A_PremPayor = '1') ">
								<xsl:attribute name="RelatedObjectID">Party_PINS</xsl:attribute>
							</xsl:if>
							<xsl:if
								test="(./instanceData/TXLife/A_PremPayor !='-1' and ./instanceData/TXLife/A_PremPayor = '2') ">
								<xsl:if
									test="(./instanceData/TXLife/A_OwnerTypeLife_OWN1 != '100' and string-length(./instanceData/TXLife/A_EntityName_OWN1)>0 )">
									<xsl:attribute name="RelatedObjectID">Party_ENTITY1</xsl:attribute>
								</xsl:if>
								<xsl:if
									test="(./instanceData/TXLife/A_OwnerTypeLife_OWN1 = '100' and 
								(string-length(./instanceData/TXLife/A_FirstName_OWN1) > 0 or
								string-length(./instanceData/TXLife/A_LastName_OWN1) > 0))">
									<xsl:attribute name="RelatedObjectID">Party_OWN1</xsl:attribute>
								</xsl:if>
							</xsl:if>
							<xsl:if
								test="(./instanceData/TXLife/A_PayorType) !='-1' and (./instanceData/TXLife/A_PremPayor) ='3' and 
						(string-length(./instanceData/TXLife/A_EntityName_PYR))  >  0 or
						(string-length(./instanceData/TXLife/A_FirstName_PYR))  >  0 or
						(string-length(./instanceData/TXLife/A_LastName_PYR))  >  0">
								<xsl:attribute name="RelatedObjectID">Party_PYR</xsl:attribute>
							</xsl:if>
							<xsl:if test="(./instanceData/TXLife/A_PremPayor!='-1')">
								<OriginatingObjectType tc="4">Holding</OriginatingObjectType>
								<RelatedObjectType tc="6">Party</RelatedObjectType>
								<RelationRoleCode tc="31">Payor</RelationRoleCode>
							</xsl:if>
							<xsl:if
								test="(./instanceData/TXLife/A_PremPayor!='-1' and ./instanceData/TXLife/A_PremPayor = '1') ">
								<RelationDescription tc="91">Self</RelationDescription>
							</xsl:if>
							<xsl:if
								test="(./instanceData/TXLife/A_PremPayor!='-1' and ./instanceData/TXLife/A_PremPayor = '2') ">
								<xsl:if test="./instanceData/TXLife/A_RelToPI_OWN1!='-1'">
									<RelationDescription>
										<xsl:attribute name="tc">
														<xsl:value-of select="instanceData/TXLife/A_RelToPI_OWN1" />
													</xsl:attribute>
										<xsl:value-of select="instanceData/TXLife/A_RelToPI_OWN1_Desc" />
									</RelationDescription>
								</xsl:if>
							</xsl:if>
							<xsl:if
								test="(./instanceData/TXLife/A_PremPayor!='-1' and ./instanceData/TXLife/A_PremPayor = '3')">
								<xsl:if test="./instanceData/TXLife/A_RelToPI_PYR!='-1'">
									<RelationDescription>
										<xsl:attribute name="tc">
														<xsl:value-of select="instanceData/TXLife/A_RelToPI_PYR" />
													</xsl:attribute>
										<xsl:value-of select="instanceData/TXLife/A_RelToPI_PYR_Desc" />
									</RelationDescription>
								</xsl:if>
							</xsl:if>
						</Relation>
					</xsl:if>
					<!-- Relation for Authorized Person For Entity Payor -->
					<xsl:if
						test="(./instanceData/TXLife/A_PayorType) !='-1' and (./instanceData/TXLife/A_PremPayor) ='3' and 
						(string-length(./instanceData/TXLife/A_EntityName_PYR))  >  0 or
						(string-length(./instanceData/TXLife/A_ContactFirstName_PYR))  >  0 or
						(string-length(./instanceData/TXLife/A_ContactLastName_PYR))  >  0">
						<Relation id="Relation_PYR_AUTHORIZED"
							OriginatingObjectID="Party_PYR" RelatedObjectID="Party_PYR_AUTHORIZED">
							<OriginatingObjectType tc="6">Party
							</OriginatingObjectType>
							<RelatedObjectType tc="6">Party</RelatedObjectType>
							<xsl:if test="./instanceData/TXLife/A_PayorType  = '2'">
								<RelationRoleCode tc="146">Business Partner
								</RelationRoleCode>
							</xsl:if>
							<xsl:if
								test="./instanceData/TXLife/A_PayorType  = '1' or 
													./instanceData/TXLife/A_PayorType = '6'  or 
													./instanceData/TXLife/A_PayorType = '13' or 
													 ./instanceData/TXLife/A_PayorType = '11' or 
													 ./instanceData/TXLife/A_PayorType = '2147483647'  ">
								<RelationRoleCode tc="1009900003">Company Officer
								</RelationRoleCode>
							</xsl:if>
							<xsl:if test="./instanceData/TXLife/A_PayorType = '16'">
								<RelationRoleCode tc="69">Trustee</RelationRoleCode>
							</xsl:if>
						</Relation>
					</xsl:if>
					<!-- Owner Relation when insured is Owner BHFD-1042 -->
					<xsl:if test="./instanceData/TXLife/A_PIOtherThanOwn = '0'">
						<Relation id="Relation_OWN1" OriginatingObjectID="Holding_1"
							RelatedObjectID="Party_PINS">
							<OriginatingObjectType tc="4">Holding
							</OriginatingObjectType>
							<RelatedObjectType tc="6">Party</RelatedObjectType>
							<RelationRoleCode tc="8">Owner</RelationRoleCode>
							<RelationDescription tc="91">Self
							</RelationDescription>
						</Relation>
					</xsl:if>
					<!-- OWN Relation -->
					<xsl:if test="./instanceData/TXLife/A_PIOtherThanOwn = '1'">
						<xsl:for-each select="instanceData/TXLife/*">
							<xsl:if test="starts-with(name(),'A_FirstName_OWN')">
								<xsl:variable name="pos" select="substring(name(),16)" />
								<xsl:variable name="agentValue"
									select='format-number(../*[name()="A_COUNT_TOTAL_OWN"], "0")' />
								<xsl:variable name="posValue" select='format-number($pos, "0")' />
								<xsl:if test="$pos != '' and $posValue &lt;= $agentValue">
									<xsl:if
										test="string-length(../*[name()=concat('A_EntityName_OWN',$pos)]) > 0 or 
											string-length(../*[name()=concat('A_FirstName_OWN',$pos)]) > 0 or 
											string-length(../*[name()=concat('A_LastName_OWN',$pos)]) > 0 ">

										<Relation OriginatingObjectID="Holding_1">
											<xsl:attribute name="id">
													<xsl:value-of select="concat('Relation_OWN',$pos)" />
												</xsl:attribute>
											<xsl:if
												test="(../A_PIOtherThanOwn = '1' and ../*[name()=concat('A_OwnerTypeLife_OWN',$pos)] != '-1'
												and ../*[name()=concat('A_OwnerTypeLife_OWN',$pos)] != '100')">
												<xsl:attribute name="RelatedObjectID">
													<xsl:value-of select="concat('Party_ENTITY',$pos)" />
												</xsl:attribute>
											</xsl:if>
											<xsl:if
												test="(../A_PIOtherThanOwn = '1' and ../*[name()=concat('A_OwnerTypeLife_OWN',$pos)]!= '-1' and ../*[name()=concat('A_OwnerTypeLife_OWN',$pos)]= '100')">
												<xsl:attribute name="RelatedObjectID">
													<xsl:value-of select="concat('Party_OWN',$pos)" />
												</xsl:attribute>
											</xsl:if>
											<OriginatingObjectType tc="4">Holding
											</OriginatingObjectType>
											<RelatedObjectType tc="6">Party
											</RelatedObjectType>
											<xsl:if
												test="../*[name()=concat('A_OwnerCategory_OWN',$pos)] = '1'">
												<RelationRoleCode tc="8">Owner
												</RelationRoleCode>
											</xsl:if>
											<xsl:if
												test="../*[name()=concat('A_OwnerCategory_OWN',$pos)] = '2'">
												<RelationRoleCode tc="184">Additional
												</RelationRoleCode>
											</xsl:if>
											<xsl:if
												test="../*[name()=concat('A_OwnerCategory_OWN',$pos)] = '3'">
												<RelationRoleCode tc="184">Contingent
												</RelationRoleCode>
											</xsl:if>
											<xsl:if test="../A_PIOtherThanOwn = '1'">
												<xsl:if test="../*[name()=concat('A_RelToPI_OWN',$pos)]!= '-1'">
													<RelationDescription>
														<xsl:attribute name="tc">
															<xsl:value-of
															select="../*[name()=concat('A_RelToPI_OWN',$pos)]" />
														</xsl:attribute>
														<xsl:value-of
															select="../*[name()=concat('A_RelToPI_OWN',$pos,'_Desc')]" />
													</RelationDescription>
												</xsl:if>
											</xsl:if>
										</Relation>
									</xsl:if>
								</xsl:if>
							</xsl:if>
						</xsl:for-each>
					</xsl:if>
					<!-- Custodian for Primary Beneficiary Relation -->
					<xsl:for-each select="instanceData/TXLife/*">
						<xsl:if test="starts-with(name(),'A_CustFirstName_BEN')">
							<xsl:if test="string-length(.) > 0">
								<xsl:variable name="pos" select="substring(name(),20)" />
								<xsl:variable name="agentValue"
									select='format-number(../*[name()="A_COUNT_TOTAL_BEN"], "0")' />
								<xsl:variable name="posValue" select='format-number($pos, "0")' />
								<xsl:if test="$pos != '' and $posValue &lt;= $agentValue">
									<xsl:if
										test="string-length(../*[name()=concat('A_CustFirstName_BEN',$pos)])>0 or string-length(../*[name()=concat('A_CustLastName_BEN',$pos)])>0">
										<Relation>
											<xsl:attribute name="id">
															<xsl:value-of select="concat('Relation_Custodian_BEN',$pos)" />
														</xsl:attribute>
											<xsl:attribute name="OriginatingObjectID">
															<xsl:value-of select="concat('Party_BEN',$pos)" />
														</xsl:attribute>
											<xsl:attribute name="RelatedObjectID">
															<xsl:value-of select="concat('Party_Custodian_BEN',$pos)" />
														</xsl:attribute>
											<OriginatingObjectType tc="6">Party
											</OriginatingObjectType>
											<RelatedObjectType tc="6">Party
											</RelatedObjectType>
											<RelationRoleCode tc="57">Custodian
											</RelationRoleCode>
										</Relation>
									</xsl:if>
								</xsl:if>
							</xsl:if>
						</xsl:if>
					</xsl:for-each>
					<!-- Custodian for Contigent Beneficiary Relation -->
					<xsl:for-each select="instanceData/TXLife/*">
						<xsl:if test="starts-with(name(),'A_CustFirstName_CBN')">
							<xsl:if test="string-length(.) > 0">
								<xsl:variable name="pos" select="substring(name(),20)" />
								<xsl:variable name="agentValue"
									select='format-number(../*[name()="A_COUNT_TOTAL_CBN"], "0")' />
								<xsl:variable name="posValue" select='format-number($pos, "0")' />
								<xsl:if test="$pos != '' and $posValue &lt;= $agentValue">
									<xsl:if
										test="string-length(../*[name()=concat('A_CustFirstName_CBN',$pos)])>0 or string-length(../*[name()=concat('A_CustLastName_CBN',$pos)])>0">
										<Relation>
											<xsl:attribute name="id">
															<xsl:value-of select="concat('Relation_Custodian_CBN',$pos)" />
														</xsl:attribute>
											<xsl:attribute name="OriginatingObjectID">
															<xsl:value-of select="concat('Party_CBN',$pos)" />
														</xsl:attribute>
											<xsl:attribute name="RelatedObjectID">
															<xsl:value-of select="concat('Party_Custodian_CBN',$pos)" />
														</xsl:attribute>
											<OriginatingObjectType tc="6">Party
											</OriginatingObjectType>
											<RelatedObjectType tc="6">Party
											</RelatedObjectType>
											<RelationRoleCode tc="57">Custodian
											</RelationRoleCode>
										</Relation>
									</xsl:if>
								</xsl:if>
							</xsl:if>
						</xsl:if>
					</xsl:for-each>
					<!-- AGT Relation Holding/Party -->
					<xsl:for-each select="instanceData/TXLife/*">
						<xsl:if test="starts-with(name(),'A_AgentID_AGT')">
							<xsl:if test="string-length(.) > 0">
								<xsl:variable name="pos" select="substring(name(),14)" />
								<xsl:variable name="agentValue"
									select='format-number(../*[name()="A_COUNT_TOTAL_AGT"], "0")' />
								<xsl:variable name="posValue" select='format-number($pos, "0")' />
								<xsl:if test="$pos != '' and $posValue &lt;= $agentValue">
									<xsl:if
										test="string-length(../*[name()=concat('A_FirstName_AGT',$pos)])>0 or 
											string-length(../*[name()=concat('A_LastName_AGT',$pos)])>0">
										<Relation OriginatingObjectID="Holding_1">
											<xsl:attribute name="RelatedObjectID">
														<xsl:value-of select="concat('Party_AGT',$pos)" />
													</xsl:attribute>
											<xsl:attribute name="id">
														<xsl:value-of select="concat('Relation_AGT',$pos)" />
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
											<OLifEExtension ExtensionCode="Relation 2.8.90"
												VendorCode="05">
												<!-- AMERNBA-1152 -->
												<RelationProducerExtension>
													<!-- BHFD-529 -->
													<xsl:if
														test="string-length(../*[name()=concat('A_ProfileCode_AGT',$pos)])>0 ">
														<SituationCode>
															<xsl:value-of
																select="../*[name()=concat('A_ProfileCode_AGT',$pos)]" />
														</SituationCode>
													</xsl:if>
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
					<!-- BEN Relation -->
					<xsl:for-each select="instanceData/TXLife/*">
						<xsl:if test="starts-with(name(),'A_BeneficiaryType_BEN')">
							<xsl:if test="string-length(.) > 0">
								<xsl:variable name="pos" select="substring(name(),22)" />
								<xsl:variable name="benValue"
									select='format-number(../*[name()="A_COUNT_TOTAL_BEN"], "0")' />
								<xsl:variable name="posValue" select='format-number($pos, "0")' />
								<xsl:if test="$pos != '' and $posValue &lt;= $benValue">
									<xsl:if
										test="string-length(../*[name()=concat('A_FirstName_BEN',$pos)])> 0 or string-length(../*[name()=concat('A_LastName_BEN',$pos)])> 0 or string-length(../*[name()=concat('A_EntityName_BEN',$pos)])> 0 ">
										<Relation OriginatingObjectID="Coverage_1">
											<xsl:attribute name="RelatedObjectID">
														<xsl:value-of select="concat('Party_BEN',$pos)" />
													</xsl:attribute>
											<xsl:attribute name="id">
														<xsl:value-of select="concat('Relation_BEN',$pos)" />
													</xsl:attribute>
											<!--BHFD-1400 -->
											<OriginatingObjectType tc="20">Coverage</OriginatingObjectType>
											<RelatedObjectType tc="6">Party</RelatedObjectType>
											<RelationRoleCode tc="34">Beneficiary</RelationRoleCode>
											<xsl:choose>
												<xsl:when
													test="../*[name()=concat('A_RelToInsured_BEN',$pos)] = '1000500013'">
													<RelationDescription tc="1000500022">Relative
													</RelationDescription>
												</xsl:when>
												<xsl:when
													test="../*[name()=concat('A_RelToInsured_BEN',$pos)] = '1009900002'">
													<RelationDescription tc="1009900005">Insureds
														Company
													</RelationDescription>
												</xsl:when>
												<xsl:when
													test="../*[name()=concat('A_RelToInsured_BEN',$pos)] 
													= '1009900003'">
													<RelationDescription tc="1009900007">Irrevocable
														Trustee
													</RelationDescription>
												</xsl:when>
												<xsl:when
													test="../*[name()=concat('A_RelToInsured_BEN',$pos)] 
													= '1000500005'">
													<RelationDescription tc="1000500014">Business
														Associate
													</RelationDescription>
												</xsl:when>
												<xsl:when
													test="../*[name()=concat('A_RelToInsured_BEN',$pos)] 
													= '1000500006'">
													<RelationDescription tc="1000500014">Business
														Associate
													</RelationDescription>
												</xsl:when>
												<xsl:when
													test="../*[name()=concat('A_RelToInsured_BEN',$pos)] 
													= '1000500007'">
													<RelationDescription tc="1000500016">Charity
													</RelationDescription>
												</xsl:when>
												<xsl:when
													test="../*[name()=concat('A_RelToInsured_BEN',$pos)] 
													= '1000500008'">
													<RelationDescription tc="1000500018">Employer
													</RelationDescription>
												</xsl:when>
												<xsl:when
													test="../*[name()=concat('A_RelToInsured_BEN',$pos)] 
													= '1000500009'">
													<RelationDescription tc="1000500015">Partner
													</RelationDescription>
												</xsl:when>
												<xsl:when
													test="../*[name()=concat('A_RelToInsured_BEN',$pos)] 
													= '1000500010'">
													<RelationDescription tc="1009900006">Grandchild
													</RelationDescription>
												</xsl:when>
												<xsl:when
													test="../*[name()=concat('A_RelToInsured_BEN',$pos)] 
													= '1009900001'">
													<RelationDescription tc="1009900004">Friend
													</RelationDescription>
												</xsl:when>
												<xsl:when
													test="../*[name()=concat('A_RelToInsured_BEN',$pos)] 
													= '1000500012'">
													<RelationDescription tc="1000500013">No Relation
													</RelationDescription>
												</xsl:when>
												<xsl:when
													test="../*[name()=concat('A_RelToInsured_BEN',$pos)] 
													= '9999'">
													<RelationDescription tc="1000500023">Unknown
													</RelationDescription>
												</xsl:when>
												<xsl:when
													test="../*[name()=concat('A_RelToInsured_BEN',$pos)] 
													= '1000500014'">
													<RelationDescription tc="1000500012">Children
													</RelationDescription>
												</xsl:when>
												<xsl:when
													test="../*[name()=concat('A_RelToInsured_BEN',$pos)] = '13'">
													<RelationDescription tc="1000500012">Children
													</RelationDescription>
												</xsl:when>
												<xsl:when
													test="../*[name()=concat('A_RelToInsured_BEN',$pos)] 
													= '2'">
													<RelationDescription tc="1000500011">Estate of
														Insured
													</RelationDescription>
												</xsl:when>
												<xsl:when
													test="../*[name()=concat('A_RelToInsured_BEN',$pos)] = '20'">
													<RelationDescription tc="1000500006">Parents
													</RelationDescription>
												</xsl:when>
												<xsl:when
													test="../*[name()=concat('A_RelToInsured_BEN',$pos)] = '4'">
													<RelationDescription tc="1000500017">Creditors
													</RelationDescription>
												</xsl:when>
												<xsl:when
													test="../*[name()=concat('A_RelToInsured_BEN',$pos)] 
													= '51'">
													<RelationDescription tc="1000500004">Corporation
													</RelationDescription>
												</xsl:when>
												<xsl:when
													test="../*[name()=concat('A_RelToInsured_BEN',$pos)] = '7'">
													<RelationDescription tc="1000500019">Trust
													</RelationDescription>
												</xsl:when>
												<xsl:when
													test="../*[name()=concat('A_RelToInsured_BEN',$pos)] 
													= '9'">
													<RelationDescription tc="900">Spouse
													</RelationDescription>
												</xsl:when>
												<xsl:when
													test="../*[name()=concat('A_RelToInsured_BEN',$pos)] 
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
													select="../*[name()=concat('A_RelToInsured_BEN',$pos)]" />
														</xsl:attribute>
												<xsl:value-of
													select="../*[name()=concat('A_RelToInsured_BEN',$pos, '_Desc')]" />
											</BeneficiaryDesignation>
											<OLifEExtension ExtensionCode="Relation 2.8.90"
												VendorCode="05">
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
								<xsl:variable name="pos" select="substring(name(),22)" />
								<xsl:variable name="benValue"
									select='format-number(../*[name()="A_COUNT_TOTAL_CBN"], "0")' />
								<xsl:variable name="posValue" select='format-number($pos, "0")' />
								<xsl:if test="$pos != '' and $posValue &lt;= $benValue">
									<xsl:if
										test="string-length(../*[name()=concat('A_FirstName_CBN',$pos)])> 0 or string-length(../*[name()=concat('A_LastName_CBN',$pos)])> 0 or string-length(../*[name()=concat('A_EntityName_CBN',$pos)])> 0 ">
										<Relation OriginatingObjectID="Coverage_1">
											<xsl:attribute name="RelatedObjectID">
														<xsl:value-of select="concat('Party_CBN',$pos)" />
													</xsl:attribute>
											<xsl:attribute name="id">
														<xsl:value-of select="concat('Relation_CBN',$pos)" />
													</xsl:attribute>
											<!--BHFD-1400 -->
											<OriginatingObjectType tc="20">Coverage</OriginatingObjectType>
											<RelatedObjectType tc="6">Party</RelatedObjectType>
											<RelationRoleCode tc="36">Contigent Beneficiary</RelationRoleCode>
											<xsl:choose>
												<xsl:when
													test="../*[name()=concat('A_RelToInsured_CBN',$pos)] = '1000500013'">
													<RelationDescription tc="1000500022">Relative
													</RelationDescription>
												</xsl:when>
												<xsl:when
													test="../*[name()=concat('A_RelToInsured_CBN',$pos)] = '1009900002'">
													<RelationDescription tc="1009900005">Insureds
														Company
													</RelationDescription>
												</xsl:when>
												<xsl:when
													test="../*[name()=concat('A_RelToInsured_CBN',$pos)] 
													= '1009900003'">
													<RelationDescription tc="1009900007">Irrevocable
														Trustee
													</RelationDescription>
												</xsl:when>
												<xsl:when
													test="../*[name()=concat('A_RelToInsured_CBN',$pos)] 
													= '1000500005'">
													<RelationDescription tc="1000500014">Business
														Associate
													</RelationDescription>
												</xsl:when>
												<xsl:when
													test="../*[name()=concat('A_RelToInsured_CBN',$pos)] 
													= '1000500006'">
													<RelationDescription tc="1000500014">Business
														Associate
													</RelationDescription>
												</xsl:when>
												<xsl:when
													test="../*[name()=concat('A_RelToInsured_CBN',$pos)] 
													= '1000500007'">
													<RelationDescription tc="1000500016">Charity
													</RelationDescription>
												</xsl:when>
												<xsl:when
													test="../*[name()=concat('A_RelToInsured_CBN',$pos)] 
													= '1000500008'">
													<RelationDescription tc="1000500018">Employer
													</RelationDescription>
												</xsl:when>
												<xsl:when
													test="../*[name()=concat('A_RelToInsured_CBN',$pos)] 
													= '1000500009'">
													<RelationDescription tc="1000500015">Partner
													</RelationDescription>
												</xsl:when>
												<xsl:when
													test="../*[name()=concat('A_RelToInsured_CBN',$pos)] 
													= '1000500010'">
													<RelationDescription tc="1009900006">Grandchild
													</RelationDescription>
												</xsl:when>
												<xsl:when
													test="../*[name()=concat('A_RelToInsured_CBN',$pos)] 
													= '1009900001'">
													<RelationDescription tc="1009900004">Friend
													</RelationDescription>
												</xsl:when>
												<xsl:when
													test="../*[name()=concat('A_RelToInsured_CBN',$pos)] 
													= '1000500012'">
													<RelationDescription tc="1000500013">No Relation
													</RelationDescription>
												</xsl:when>
												<xsl:when
													test="../*[name()=concat('A_RelToInsured_CBN',$pos)] 
													= '9999'">
													<RelationDescription tc="1000500023">Unknown
													</RelationDescription>
												</xsl:when>
												<xsl:when
													test="../*[name()=concat('A_RelToInsured_CBN',$pos)] 
													= '1000500014'">
													<RelationDescription tc="1000500012">Children
													</RelationDescription>
												</xsl:when>
												<xsl:when
													test="../*[name()=concat('A_RelToInsured_CBN',$pos)] = '13'">
													<RelationDescription tc="1000500012">Children
													</RelationDescription>
												</xsl:when>
												<xsl:when
													test="../*[name()=concat('A_RelToInsured_CBN',$pos)] 
													= '2'">
													<RelationDescription tc="1000500011">Estate of
														Insured
													</RelationDescription>
												</xsl:when>
												<xsl:when
													test="../*[name()=concat('A_RelToInsured_CBN',$pos)] = '20'">
													<RelationDescription tc="1000500006">Parents
													</RelationDescription>
												</xsl:when>
												<xsl:when
													test="../*[name()=concat('A_RelToInsured_CBN',$pos)] = '4'">
													<RelationDescription tc="1000500017">Creditors
													</RelationDescription>
												</xsl:when>
												<xsl:when
													test="../*[name()=concat('A_RelToInsured_CBN',$pos)] 
													= '51'">
													<RelationDescription tc="1000500004">Corporation
													</RelationDescription>
												</xsl:when>
												<xsl:when
													test="../*[name()=concat('A_RelToInsured_CBN',$pos)] = '7'">
													<RelationDescription tc="1000500019">Trust
													</RelationDescription>
												</xsl:when>
												<xsl:when
													test="../*[name()=concat('A_RelToInsured_CBN',$pos)] 
													= '9'">
													<RelationDescription tc="900">Spouse
													</RelationDescription>
												</xsl:when>
												<xsl:when
													test="../*[name()=concat('A_RelToInsured_CBN',$pos)] 
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
													select="../*[name()=concat('A_RelToInsured_CBN',$pos)]" />
														</xsl:attribute>
												<xsl:value-of
													select="../*[name()=concat('A_RelToInsured_CBN',$pos, '_Desc')]" />
											</BeneficiaryDesignation>
											<OLifEExtension ExtensionCode="Relation 2.8.90"
												VendorCode="05">
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
				<xsl:value-of select="concat($year,'-',$month,'-',$day)" />
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