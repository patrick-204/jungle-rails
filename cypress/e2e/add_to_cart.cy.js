describe("Add to cart", () => {

  it("should increase the cart count by one when the 'Add to Cart' button is pressed", () => {
    cy.visit("/");

    cy.get(".products article").should("have.length", 2);

    cy.get('nav .nav-item .nav-link').contains('My Cart').invoke('text').then((text) => {
      let initialCount = parseInt(text.match(/\d+/)[0], 10); 

      cy.get('.products article').first().within(() => {
        cy.get('button.btn').click();
      });


      cy.visit('/'); 

      cy.get('nav .nav-item .nav-link').contains('My Cart').invoke('text').then((text) => {
        let updatedCount = parseInt(text.match(/\d+/)[0], 10);
        expect(updatedCount).to.equal(initialCount + 1);
      });
    });


  });


});