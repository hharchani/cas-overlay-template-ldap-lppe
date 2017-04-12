<jsp:directive.include file="includes/top.jsp" />

<c:if test="${not pageContext.request.secure}">
    <div id="msg" class="errors">
        <h2><spring:message code="screen.nonsecure.title" /></h2>
        <p><spring:message code="screen.nonsecure.message" /></p>
    </div>
</c:if>

<div id="cookiesDisabled" class="errors" style="display:none;">
    <h2><spring:message code="screen.cookies.disabled.title" /></h2>
    <p><spring:message code="screen.cookies.disabled.message" /></p>
</div>

<%--
    <c:if test="${not empty registeredService}">
        <c:set var="registeredServiceLogo" value="images/webapp.png"/>
        <c:set var="registeredServiceName" value="${registeredService.name}"/>
        <c:set var="registeredServiceDescription" value="${registeredService.description}"/>
        <c:choose>
            <c:when test="${not empty mduiContext}">
                <c:if test="${not empty mduiContext.logoUrl}">
                    <c:set var="registeredServiceLogo" value="${mduiContext.logoUrl}"/>
                </c:if>
                <c:set var="registeredServiceName" value="${mduiContext.displayName}"/>
                <c:set var="registeredServiceDescription" value="${mduiContext.description}"/>
            </c:when>
            <c:when test="${not empty registeredService.logo}">
                <c:set var="registeredServiceLogo" value="${registeredService.logo}"/>
            </c:when>
        </c:choose>
        <div id="serviceui" class="serviceinfo">
            <table>
                <tr>
                    <td><img src="${registeredServiceLogo}"></td>
                    <td id="servicedesc">
                        <h1>${fn:escapeXml(registeredServiceName)}</h1>
                        <p>${fn:escapeXml(registeredServiceDescription)}</p>
                    </td>
                </tr>
            </table>
        </div>
        <p/>
    </c:if>
--%>

<div class="row">
    <div class="col-half form">
        <form:form method="post" id="fm1" commandName="${commandName}" htmlEscape="true">
            <h2>Login</h2>
            <label for="username">
                Email
                <c:choose>
                    <c:when test="${not empty sessionScope.openIdLocalId}">
                        <strong><c:out value="${sessionScope.openIdLocalId}" /></strong>
                        <input type="hidden" id="username" name="username" value="<c:out value="${sessionScope.openIdLocalId}" />" />
                    </c:when>
                    <c:otherwise>
                        <spring:message code="screen.welcome.label.netid.accesskey" var="userNameAccessKey" />
                        <form:input
                            accesskey="${userNameAccessKey}"
                            autocomplete="email"
                            autocapitalize="off"
                            autocorrect="off"
                            cssClass="required"
                            cssErrorClass="error"
                            htmlEscape="true"
                            id="username"
                            path="username"
                            required="required"
                            spellcheck="false"
                            tabindex="1"
                            type="text"/>

                    </c:otherwise>
                </c:choose>
            </label>
            <label for="password">
                Password
                <form:password
                    cssClass="required"
                    cssErrorClass="error"
                    id="password"
                    tabindex="2"
                    path="password"
                    accesskey="${passwordAccessKey}"
                    htmlEscape="true"
                    autocomplete="off"
                    required="required"/>
            </label>
            <span id="capslock-on" style="display:none;"><p class="capslock-msg"><img src="images/warning.png"> <spring:message code="screen.capslock.on" /></p></span>

            <form:errors path="*" cssClass="errors" element="div" htmlEscape="false" />

            <%--
                <section class="row check">
                    <p>
                        <input id="warn" name="warn" value="true" tabindex="3" accesskey="<spring:message code="screen.welcome.label.warn.accesskey" />" type="checkbox" />
                        <label for="warn"><spring:message code="screen.welcome.label.warn" /></label>
                        <br/>
                        <input id="publicWorkstation" name="publicWorkstation" value="false" tabindex="4" type="checkbox" />
                        <label for="publicWorkstation"><spring:message code="screen.welcome.label.publicstation" /></label>
                        <br/>
                        <input type="checkbox" name="rememberMe" id="rememberMe" value="true" tabindex="5"  />
                        <label for="rememberMe"><spring:message code="screen.rememberme.checkbox.title" /></label>
                    </p>
                </section>
            --%>

            <div class="label">
                <input class="btn-submit submit" name="submit" accesskey="l" value="<spring:message code="screen.welcome.button.login" />" tabindex="6" type="submit" />
                <%--
                    <input class="btn-reset submit" name="reset" accesskey="c" value="<spring:message code="screen.welcome.button.clear" />" tabindex="7" type="reset" />
                --%>
            </div>
            <input type="hidden" name="execution" value="${flowExecutionKey}" />
            <input type="hidden" name="_eventId" value="submit" />
            <a href="https://passwordreset.iiit.ac.in">Change password</a>
        </form:form>
    </div>
    <div class="col-half note">
        <h2>Note: </h2>
        <ol>
            <li>Since CAS does not support Single Sign-Out as of now, please make sure you logout from all the applications and close the browser window when you have finished using the system.</li>
            <li>IT Support will NEVER ask for your password and/or any other personal information. Please do not reply to any such mail and report them immediately to IT support</li>
            <li>It is recommended you choose a strong password since this single password is your gateway to all the computing resources at IIIT-H</li>
        </ol>
    </div>
</div>

<%--
    <div id="sidebar">
        <div class="sidebar-content">
            <p><spring:message code="screen.welcome.security" /></p>
            <c:if test="${!empty pac4jUrls}">
                <div id="list-providers">
                    <h3><spring:message code="screen.welcome.label.loginwith" /></h3>
                    <form>
                        <ul>
                            <c:forEach var="entry" items="${pac4jUrls}">
                                <li><a href="${entry.value}">${entry.key}</a></li>
                            </c:forEach>
                        </ul>
                    </form>
                </div>
            </c:if>
            <div id="list-languages">
                <%final String queryString = request.getQueryString() == null ? "" : request.getQueryString().replaceAll("&locale=([A-Za-z][A-Za-z]_)?[A-Za-z][A-Za-z]|^locale=([A-Za-z][A-Za-z]_)?[A-Za-z][A-Za-z]", "");%>
                <c:set var='query' value='<%=queryString%>' />
                <c:set var="xquery" value="${fn:escapeXml(query)}" />
                <h3>Languages:</h3>
                <c:choose>
                    <c:when test="${not empty requestScope['isMobile'] and not empty mobileCss}">
                        <form method="get" action="login?${xquery}">
                            <select name="locale">
                                <option value="en">English</option>
                                <option value="es">Spanish</option>
                                <option value="fr">French</option>
                                <option value="ru">Russian</option>
                                <option value="nl">Nederlands</option>
                                <option value="sv">Svenska</option>
                                <option value="it">Italiano</option>
                                <option value="ur">Urdu</option>
                                <option value="zh_CN">Chinese (Simplified)</option>
                                <option value="zh_TW">Chinese (Traditional)</option>
                                <option value="de">Deutsch</option>
                                <option value="ja">Japanese</option>
                                <option value="hr">Croatian</option>
                                <option value="uk">Ukranian</option>
                                <option value="cs">Czech</option>
                                <option value="sk">Slovak</option>
                                <option value="sl">Slovenian</option>
                                <option value="pl">Polish</option>
                                <option value="ca">Catalan</option>
                                <option value="mk">Macedonian</option>
                                <option value="fa">Farsi</option>
                                <option value="ar">Arabic</option>
                                <option value="pt_PT">Portuguese</option>
                                <option value="pt_BR">Portuguese (Brazil)</option>
                            </select>
                            <input type="submit" value="Switch">
                        </form>
                    </c:when>
                    <c:otherwise>
                        <c:set var="loginUrl" value="login?${xquery}${not empty xquery ? '&' : ''}locale=" />
                        <ul>
                            <li class="first"><a href="${loginUrl}en">English</a></li>
                            <li><a href="${loginUrl}es">Spanish</a></li>
                            <li><a href="${loginUrl}fr">French</a></li>
                            <li><a href="${loginUrl}ru">Russian</a></li>
                            <li><a href="${loginUrl}nl">Nederlands</a></li>
                            <li><a href="${loginUrl}sv">Svenska</a></li>
                            <li><a href="${loginUrl}it">Italiano</a></li>
                            <li><a href="${loginUrl}ur">Urdu</a></li>
                            <li><a href="${loginUrl}zh_CN">Chinese (Simplified)</a></li>
                            <li><a href="${loginUrl}zh_TW">Chinese (Traditional)</a></li>
                            <li><a href="${loginUrl}de">Deutsch</a></li>
                            <li><a href="${loginUrl}ja">Japanese</a></li>
                            <li><a href="${loginUrl}hr">Croatian</a></li>
                            <li><a href="${loginUrl}uk">Ukranian</a></li>
                            <li><a href="${loginUrl}cs">Czech</a></li>
                            <li><a href="${loginUrl}sk">Slovak</a></li>
                            <li><a href="${loginUrl}sl">Slovenian</a></li>
                            <li><a href="${loginUrl}ca">Catalan</a></li>
                            <li><a href="${loginUrl}mk">Macedonian</a></li>
                            <li><a href="${loginUrl}fa">Farsi</a></li>
                            <li><a href="${loginUrl}ar">Arabic</a></li>
                            <li><a href="${loginUrl}pt_PT">Portuguese</a></li>
                            <li><a href="${loginUrl}pt_BR">Portuguese (Brazil)</a></li>
                            <li class="last"><a href="${loginUrl}pl">Polish</a></li>
                        </ul>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
--%>

<spring:theme code="cas.javascript.file" var="casJavascriptFile" text="" />
<script type="text/javascript" src="<c:url value="${casJavascriptFile}" />?v=2"></script>
<jsp:directive.include file="includes/bottom.jsp" />
