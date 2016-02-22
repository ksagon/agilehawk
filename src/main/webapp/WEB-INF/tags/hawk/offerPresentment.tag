<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%@ attribute name="layout" required="false" description="Hero (spans 3 columns), standard (default if none specified), details, or history." %>
<%@ attribute name="advertiserName" required="true" description="The name of the advertiser for this offer" %>
<%@ attribute name="lifestyleImage" required="true" description="URL. 350x220 for standard and history. 970x250 for hero and details." %>
<%@ attribute name="logoImage" required="true" description="URL. 80x60 for standard and history. 115x115 for hero and details." %>
<%@ attribute name="dealConstruct" required="true" description="Full string consisting of deal amount and threshold, e.g., '$5 back on $50 purchase'" %>
<%@ attribute name="marketingMessage" required="true" description="The marketing copy that will be displayed alongside this offer." %>
<%@ attribute name="channel" required="true" description="Examples: In-store, Online" type="com.edo.common.model.MessageCodeType" %>
<%@ attribute name="expirationDate" required="true" type="java.util.Date" description="The date displayed on the offer after which the offer can no longer be redeemed." %>
<%@ attribute name="redemptionDate" required="false" type="java.util.Date" description="Required for History" %>
<%@ attribute name="website" required="false" description="Advertiser URL. Displayed in details layout" %>
<%@ attribute name="terms" required="false" description="Offer terms and conditions. Displayed in details layout" %>
<%@ attribute name="detailsLink" required="false" description="If a details page exists, provide link to page." %>

<%@ attribute name="showThumbs" required="false" description="Display thumbs up and down" %>
<%@ attribute name="dealNumber" required="false" description="Required for thumbs" %>
<%@ attribute name="rating" required="false" description="Required for thumbs" %>
<%@ attribute name="activationType" required="false" description="used to determine if offer is a partner offer" %>

<c:set var="thumbsUpClass" value="${rating eq 1.0 ? 'active' : ''}" />
<c:set var="thumbsDownClass" value="${not empty rating and rating eq 0.0 ? 'active' : ''}" />

<c:choose>
    <c:when test="${layout == 'hero'}">
        <c:set var="panelCss" value="offer-hero" />
        <c:set var="logoWidth" value="115" />
        <c:set var="logoHeight" value="115" />
    </c:when>
    <c:when test="${layout == 'details'}">
        <c:set var="panelCss" value="offer-details" />
        <c:set var="logoWidth" value="115" />
        <c:set var="logoHeight" value="115" />
    </c:when>
    <c:when test="${layout == 'history'}">
        <c:set var="panelCss" value="history" />
        <c:set var="logoWidth" value="80" />
        <c:set var="logoHeight" value="60" />
    </c:when>
    <c:otherwise>
        <c:set var="logoWidth" value="80" />
        <c:set var="logoHeight" value="60" />
    </c:otherwise>
</c:choose>

<c:if test="${not empty detailsLink}">
    <c:set var="panelCss">${panelCss} details-link</c:set>
</c:if>

<fmt:formatDate var="expirationDateFormatted" value="${expirationDate}" dateStyle="short" />
<fmt:formatDate var="redemptionDateFormatted" value="${redemptionDate}" dateStyle="short" />

<article>

<div class="panel panel-offer-presentment ${panelCss}">
    <c:choose>
        <c:when test="${layout == 'details'}">
            <div class="panel-heading">
                <div class="offer-summary">
                    <strong aria-hidden="true">${advertiserName}</strong>
                    <h1>${dealConstruct} <span class="sr-only">at ${advertiserName}</span></h1>
                </div>
                <div class="offer-logo">
                    <img src="${logoImage}" width="${logoWidth}" height="${logoHeight}" alt="" />
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <div class="panel-heading" style="background-image: url('${lifestyleImage}');">
                <div class="panel-title">
                    <strong aria-hidden="true">${advertiserName}</strong>
                    <c:if test="${showThumbs && layout != 'details'}">
                        <div class="thumbs-container">
                            <div class="btn-group" data-toggle="buttons">
                                <button type="button"
                                        class="btn btn-default btn-thumbs thumbs-up ${thumbsUpClass}"
                                        data-rating="1"
                                        title="<spring:message code="ux.copy.offerPresentment.likeOffer" />"
                                        onclick="edo.offer.triggerRatingUpdate(event, ${dealNumber})">
                                    <span class="fa fa-thumbs-up"></span>
                                    <span class="sr-only"><spring:message code="ux.copy.offerPresentment.likeOfferScreenReader" arguments="${dealConstruct},${advertiserName}" /></span>
                                </button>
                                <button type="button"
                                        class="btn btn-default btn-thumbs thumbs-down ${thumbsDownClass}"
                                        data-rating="0"
                                        title="<spring:message code="ux.copy.offerPresentment.dislikeOffer" />"
                                        onclick="edo.offer.triggerRatingUpdate(event, ${dealNumber})">
                                    <span class="fa fa-thumbs-down"></span>
                                    <span class="sr-only"><spring:message code="ux.copy.offerPresentment.dislikeOfferScreenReader" arguments="${dealConstruct},${advertiserName}" /></span>
                                </button>
                            </div>
                        </div>
                    </c:if>
                </div>
            </div>
        </c:otherwise>
    </c:choose>

    <div class="panel-body">
        <div class="row">
            <div class="offer-summary">
                <c:if test="${layout != 'details'}">
                    <h2>
                        <c:if test="${not empty detailsLink}">
                            <a href="${detailsLink}" title='<spring:message code="ux.copy.offerPresentment.offerDetailsLink" arguments="${advertiserName}" />' class="detailsLink">
                        </c:if>
                        <spring:message code="ux.copy.offerPresentment.dealConstructAtAdvertiserName" argumentSeparator="|" arguments="${dealConstruct}|${advertiserName}" />
                        <c:if test="${not empty detailsLink}">
                            </a>
                        </c:if>
                    </h2>
                </c:if>

                <p class="marketing-message">${marketingMessage}</p>


                <c:if test="${layout == 'details'}">
                    <p>
                        <c:set var="useButton" value="${channel != 'INSTORE'}" />
                        <a href="${website}" target="_blank" class="merchant-link <c:out value="${useButton ? 'btn btn-primary' : ''}" />">
                            <c:if test="${useButton}"><i class="fa  fa-credit-card fa-fw"></i></c:if>
                            <spring:message code="${useButton ? 'ux.copy.offerPresentment.redeemOnWebsite' : 'ux.copy.offerPresentment.visitWebsite'}" arguments="${advertiserName}" />
                        </a>
                    </p>
                </c:if>

                <c:if test="${layout == 'hero'}">
                    <div class="list-inline offer-info">
                        <div class="offer-channel">
                            <spring:message code="${channel.messageCode}" text="" />
                        </div>
                        <div class="offer-expiration"><spring:message code="ux.copy.offerPresentment.expires" arguments="${expirationDateFormatted}" /> </div>
                    </div>
                </c:if>
            </div>
            <c:if test="${layout != 'details'}">
                <div class="offer-logo">
                    <img src="${logoImage}" width="${logoWidth}" height="${logoHeight}" alt="" />
                </div>
            </c:if>
        </div>

        <c:if test="${layout != 'hero'}">
            <div class="list-inline offer-info">
                <c:choose>
                    <c:when test="${layout == 'history'}">
                            <div class="alert alert-redemption"><spring:message code="ux.copy.offerPresentment.redeemed" arguments="${redemptionDateFormatted}" /> </div>
                    </c:when>
                    <c:otherwise>
                            <div class="offer-channel">
                                <spring:message code="${channel.messageCode}" text="" />
                            </div>
                            <div class="offer-expiration"><spring:message code="ux.copy.offerPresentment.expires" arguments="${expirationDateFormatted}" /></div>
                    </c:otherwise>
                </c:choose>
            </div>
        </c:if>
        <c:if test="${layout != 'details' and layout != 'history' and activationType eq 'CLICK_THROUGH_TO_ACTIVATE' and channel eq 'ONLINE' }">
            <a href="${detailsLink}?rating=${rating}" title='<spring:message code="ux.copy.offerPresentment.offerDetailsLink" arguments="${advertiserName}" />' class="online-offer-button btn btn-primary"><i class="fa  fa-credit-card fa-fw"></i> <spring:message code="ux.action.offerPresentment.learnMore" /></a>
        </c:if>

    </div>
</div>



</article>

<c:if test="${layout == 'details'}">
    <div class="offer-terms">
        ${terms}
    </div>
</c:if>

<style>

</style>