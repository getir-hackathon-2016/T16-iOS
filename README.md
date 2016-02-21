# What is T16
T16 is a software solution for location based on delivery service. It is actually very similar to "getir". The key difference we aimed to implement is the ability to place a future order and place a regular order.

This is aimed to bring back the "kapici" character in our lives. The concept is still alive in some places but in a crowded city like istanbul, a doorman takes care of multiple apartments. So not every apartment can get "2 breads, 1 milk, 1 newspaper" every morning. 

We planned to add a future to be able to place and order which takes places on every chosen day at designated time.

This is the iOS implementation.

# T16-iOS Object Models
- OKUser
- OKProduct
- OKProductCategory
- OKCart
- OKCard
- OKAddress

#T16-iOS View Controllers
- OKLoginViewController - *Manages user authorization*
- OKRegisterViewController - *Manages user registration* 
- OKMainNavigationController - *Main navigation wrapper for all views*
- OKMenuViewController - *Drawer menu on the left*
- OKHomeViewController - *Displays user location on the map and product categories*
- OKCategoryCollectionViewCell - *Custom UICollectionViewCell for displaying product categories*
- OKProductListViewController - *Displays products in a certain category*
- OKCartViewController - *Displays products in your cart and directs to checkout*
- OKConfrimOrderViewController - *Displays total cost and order data before payment*
- OKCourierTrackingViewController - *Displays order status and courier location*
- OKUserProfileViewController - *Displays and edits user profile data*
- OKOrderViewController - *Displays previous or scheduled order*
- OKAddCreditCardViewController - *Displays credit card addition form*


#T16-iOS Third Party Libraries
- RESideMenu - https://github.com/romaonthego
- UICKeyChainStore - by Kishikawa Katsumi
- RZTransitions - http://raizlabs.com/
- Chameleon - by Vicc Alexander
- JVFloatLabeledTextField - by Jared Verdi and thanks to Matt D. Smith for the original concept.
- AFNetworking - http://afnetworking.com/

#To-Do
- Some of the methods in OKConsulate are not implemented yet. They are used to set and retrieve data from backend. These should be connected.
- App doesn't create a cart and place an order on the backend, but received products and categories are live.
- Courier tracking is simulated to demonstrate app flow. This should be replaced with data coming from socket.io to display real courier location.
- User can't add a payment method or an address. Corresponding views should be implemented. This shouldn't take a lot of time, disregarded this because it didn't serve any purpose in this hackathon.
- Add and option to pick regular order date picking to the order screen.
- Add a view to see and edit open orders.


