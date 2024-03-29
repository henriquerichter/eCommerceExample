            <c:set var="view" value="/category" scope="session"/>

            <div id="categoryLeftColumn">

                <c:forEach var="category" items="${categories}">
                    <c:choose>
                        <c:when test="${category.name == selectedCategory.name}">
                            <div class="categoryButton" id="selectedCategory">
                                <span class="categoryText">
                                    <fmt:message key="${category.name}"/>
                                </span>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <a href="<c:url value='category?${category.id}'/>" class="categoryButton">
                                <div class="categoryText">
                                    <fmt:message key="${category.name}"/>
                                </div>
                            </a>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>

            </div>

            <div id="categoryRightColumn">

                <p id="categoryTitle"><fmt:message key="${selectedCategory.name}"/></p>
                
                <table id="productTable">
                    <c:forEach var="product" items="${categoryProducts}" varStatus="iter">
                        <tr class="${((iter.index % 2) == 0) ? 'lightBlue' : 'white'}">
                            <td>
                                <img src="${initParam.productImagePath}${product.name}.png" alt="${product.name}">
                            </td>
                            <td>
                                ${product.name}
                                <br>
                                <span class="smallText">${product.description}</span>
                            </td>
                            <td><fmt:formatNumber type="currency" 
                                                  currencySymbol="&dollar;" 
                                                  value="${product.price}"/>
                            </td>
                            <td>
                                <form action="<c:url value='addToCart'/>" method="post">
                                    <input type="hidden"
                                            name="productId"
                                            value="${product.id}">
                                    <input type="submit"
                                            name="submit"
                                            value="<fmt:message key='add to cart'/>">

                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </div>