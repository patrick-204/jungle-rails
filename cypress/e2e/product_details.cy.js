describe("Product details", () => {

  it("Can navigate from the home page to the product page by clicking on a product", () => {
    cy.visit("/");

    cy.get('article').first().within(() => {

      cy.get('a').click();
    });
  
    cy.url().should('include', '/products/');

    cy.get('h1').should('exist');

    cy.get('img').should('be.visible');
  });

});
