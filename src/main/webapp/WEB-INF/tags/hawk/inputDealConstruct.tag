<%@ include file="/WEB-INF/jsp/site/taglib.jsp" %>

<%@ attribute name="amountTypePath" required="true" %>
<%@ attribute name="amountPath" required="true" %>
<%@ attribute name="thresholdPath" required="true" %>
<%@ attribute name="maxRewardPath" required="true" %>
<%@ attribute name="hasMaxRewardPath" required="true" %>
<%@ attribute name="currencyCode" required="true" %>
<%@ attribute name="locale" required="true" description="The locale to use when resolving message codes for the dealConstruct" %>

<%@ attribute name="label" required="false" description="Applies a label to the input group. Attempts to use the provided label as a message code for the i18n message bundle, and falls back to using the label itself. If the label should not be visible, use <code>labelClass='sr-only'</code> to preserve accessibility." %>
<%@ attribute name="required" required="false" %>
<%@ attribute name="readonly" required="false" %>

<c:set var="amountType"><spring:bind path="${amountTypePath}">${status.value}</spring:bind></c:set>
<c:set var="amount"><spring:bind path="${amountPath}">${status.value}</spring:bind></c:set>
<c:set var="threshold"><spring:bind path="${thresholdPath}">${status.value}</spring:bind></c:set>
<c:set var="maxReward"><spring:bind path="${maxRewardPath}">${status.value}</spring:bind></c:set>
<c:set var="hasMaxReward"><spring:bind path="${hasMaxRewardPath}">${status.value}</spring:bind></c:set>
<c:set var="amountMultiplier" value="${amountType eq 'PERCENTAGE' ? 100 : 1}" />
<c:set var="maxFractionDigitsByType" value="${amountType eq 'DOLLAR' ? 2 : 2}" />

<c:set var="groupId" value="${amountPath}_${thresholdPath}_construct" />
<c:set var="backOnSelectButtonId" value="${groupId}_back_on_type" />

<spring:eval var="amountTypeDollar" expression="T(com.edo.marketing.ui.model.AwardAmountType).DOLLAR"/>
<spring:eval var="amountTypePercentage" expression="T(com.edo.marketing.ui.model.AwardAmountType).PERCENTAGE"/>
<spring:eval var="backOnTypeLength" expression="T(com.edo.marketing.ui.campaign.model.DealConstructLength).LONG" />
<spring:eval var="backOnTypeItems" expression="T(com.edo.marketing.ui.campaign.model.DealConstructBackOnType).getOrderedMap(backOnTypeLength, locale)" />
<spring:eval var="amountTypeItems" expression="T(com.edo.marketing.ui.model.AwardAmountType).getInternationalizedOrderedMap(currencyCode)" />

<c:choose>
    <c:when test="${amountType eq 'DOLLAR' and threshold eq amount}">
        <spring:eval var="backOnTypeValue" expression="T(com.edo.marketing.ui.campaign.model.DealConstructBackOnType).BACK_ON_ANY_PURCHASE" />
    </c:when>
    <c:when test="${amountType eq 'PERCENTAGE' and edofn:isBigDecimalZero(threshold)}">
        <spring:eval var="backOnTypeValue" expression="T(com.edo.marketing.ui.campaign.model.DealConstructBackOnType).BACK_ON_ANY_PURCHASE" />
    </c:when>
    <c:otherwise>
        <spring:eval var="backOnTypeShort" expression="T(com.edo.marketing.ui.campaign.model.DealConstructLength).SHORT"/>
        <spring:eval var="backOnTypeLong" expression="T(com.edo.marketing.ui.campaign.model.DealConstructLength).LONG"/>
        <c:if test="${backOnTypeLength eq backOnTypeLong}">
            <spring:eval var="backOnTypeValue" expression="T(com.edo.marketing.ui.campaign.model.DealConstructBackOnType).BACK_ON_A_PURCHASE_OF" />
        </c:if>
        <c:if test="${backOnTypeLength eq backOnTypeShort}">
            <spring:eval var="backOnTypeValue" expression="T(com.edo.marketing.ui.campaign.model.DealConstructBackOnType).BACK_ON" />
        </c:if>
    </c:otherwise>
</c:choose>
<spring:eval var="backOnTypeValueDisplayName" expression="backOnTypeValue.getDisplayName(locale)"/>

<edo:inputGroupInline id="${groupId}" label="${label}" required="${required}" controlGroupClass="deal-construct-input-group">
    <c:choose>
    <c:when test="${readonly}">
        <fmt:formatNumber var="threshold" value="${threshold}" maxFractionDigits="2" groupingUsed="false" />

        <c:set var="amountWithType">
            <c:choose>
                <c:when test="${amountType eq 'DOLLAR'}"><fmt:formatNumber value="${amount}" currencyCode="${currencyCode}" type="CURRENCY"  maxFractionDigits="${maxFractionDigitsByType}" groupingUsed="false"/></c:when>
                <c:when test="${amountType eq 'PERCENTAGE'}"><fmt:formatNumber value="${amount}" currencyCode="${currencyCode}" type="PERCENT"  maxFractionDigits="${maxFractionDigitsByType}" groupingUsed="false"/></c:when>
                <c:otherwise>${amount}</c:otherwise>
            </c:choose>
        </c:set>
        <c:set var="maxRewardCurrency"><fmt:formatNumber value="${maxReward}" currencyCode="${currencyCode}" type="CURRENCY"  maxFractionDigits="${maxFractionDigitsByType}" groupingUsed="false"/></c:set>
        <c:set var="thresholdPhrase">
            <c:if test="${backOnTypeValue.hasPurchaseMinimum}">
                <fmt:formatNumber value="${threshold}" currencyCode="${currencyCode}" type="CURRENCY"  maxFractionDigits="${maxFractionDigitsByType}" groupingUsed="false"/>
            </c:if>
            <c:if test="${amountType eq amountTypePercentage and hasMaxReward}">
                 <spring:message code="dealConstruct.maxReward" arguments="${maxRewardCurrency}"/>
            </c:if>
        </c:set>
        <div class="form-group">
        	<div class="controls">
                <p class="form-control-static">${amountWithType} ${backOnTypeValueDisplayName} ${thresholdPhrase}</p>
            </div>
        </div>
    </c:when>

    <c:otherwise>
        <form:hidden id="${hasMaxRewardPath}_hidden" path="${hasMaxRewardPath}" cssClass="has-max-reward-hidden"/>
        <edo:inputWithSelectAddon label="label.offer.amount" path="${amountPath}" selectPath="${amountTypePath}"
                    selectItems="${amountTypeItems}" selectPlacement="prepend" controlGroupClass="amount-control-group">
            <jsp:attribute name="inputField">
                <edo:inputNumber path="${amountPath}" multiplier="${amountMultiplier}" inputOnly="true"
                                 maxFractionDigits="${maxFractionDigitsByType}" inputClass="amount-input" />
            </jsp:attribute>
        </edo:inputWithSelectAddon>
        <edo:selectButton id="${backOnSelectButtonId}" items="${backOnTypeItems}" value="${backOnTypeValue}"
                    buttonClass="back-on-select-button" containerClass="back-on-select-button-container" />
        <edo:inputBase label="label.offer.threshold" path="${thresholdPath}" controlGroupClass="threshold-control-group">
            <jsp:attribute name="inputField">
                <div class="input-group">
                    <span class="input-group-addon"><c:out value="${currencyCode}"/></span>
                    <edo:inputNumber path="${thresholdPath}" inputOnly="true" maxFractionDigits="2" inputClass="threshold-input" />
                </div>
            </jsp:attribute>
        </edo:inputBase>
        <edo:inputBase label="label.offer.maxReward" path="${maxRewardPath}" controlGroupClass="max-reward-control-group">
            <jsp:attribute name="inputField">
                <div class="input-group">
                    <span class="input-group-addon">Max reward: ${currencyCode}</span>
                    <edo:inputNumber path="${maxRewardPath}" inputOnly="true" maxFractionDigits="2" inputClass="max-reward-input" />
                </div>
            </jsp:attribute>
        </edo:inputBase>
        <script type="text/javascript">
            $(document).ready(function() {
                var amountTypeSelectButton = edo.tag.cache.inputSelectButton.get("${amountTypePath}");
                var backOnSelectButton = edo.tag.cache.selectButton.get("${backOnSelectButtonId}");
                new edo.tag.input.DealConstruct("${groupId}", amountTypeSelectButton, backOnSelectButton);
            });
        </script>
    </c:otherwise>
    </c:choose>
        <c:if test="${amountType eq amountTypePercentage and hasMaxReward}">
            <edo:inputStatic label="label.offer.maxThreshold" controlGroupClass="max-threshold-control-group">
             <span id="${maxRewardPath}_threshold">
                <fmt:formatNumber value="${maxReward / amount}" currencyCode="${currencyCode}" type="CURRENCY"  maxFractionDigits="${maxFractionDigitsByType}" groupingUsed="false"/>
             </span>
         </edo:inputStatic>
       </c:if>
</edo:inputGroupInline>
