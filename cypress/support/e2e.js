xit("There is products on the page", () => {
  cy.visit("/");
  cy.get(".products article").should("be.visible");
});
