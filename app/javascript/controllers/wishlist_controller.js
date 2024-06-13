import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  updateWishlistStatus() {
    const isUserLoggedIn = this.element.dataset.userLoggedIn === "true";
    if (!isUserLoggedIn) {
      document.getElementById("login_id").click();
      return;
    }

    const propertyId = this.element.dataset.propertyId;
    const userId = this.element.dataset.userId;

    if (this.element.dataset.status === "false") {
      this.addPropertyToWishlist(propertyId, userId);
    } else {
      this.removePropertyFromWishlist();
    }
  }

  addPropertyToWishlist(propertyId, userId) {
    const params = {
      wishlist: {
        user_id: userId,
        property_id: propertyId,
      }
    };

    const options = {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(params),
    };

    fetch('/api/wishlists', options)
      .then(response => {
        if (response.ok) {
          return response.json();
        } else {
          throw new Error(`Request failed with status ${response.status}`);
        }
      })
      .then(data => {
        
        this.element.dataset.wishlistId = data.id;
        this.element.classList.remove("fill-none");
        this.element.classList.add("fill-red");
        this.element.dataset.status = "true";
        console.log(data);
      })
      .catch(error => {
        console.error('Error adding property to wishlist:', error);
      });
  }

  removePropertyFromWishlist() {
    const wishlistId = this.element.dataset.wishlistId;
    if (!wishlistId) {
      console.error('Wishlist ID not found');
      return;
    }

    fetch(`/api/wishlists/${wishlistId}`, { method: 'DELETE' })
      .then(response => {
        if (response.ok) {
          this.element.classList.remove("fill-red");
          this.element.classList.add("fill-none");
          this.element.dataset.status = "false";
          console.log('Property removed from wishlist');
        } else {
          throw new Error(`Request failed with status ${response.status}`);
        }
      })
      .catch(error => {
        console.error('Error removing property from wishlist:', error);
      });
  }
}
