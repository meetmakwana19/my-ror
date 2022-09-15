- Always run `bundle install` again after every modifications to the gemfile.
- Out of MVC architecture, Views and Controllers must interact with Browser at each request. Models can be optional for once.
- BVC is an essential triangle.
- Routing : If rails cant find a matching doc in the public folder then it send the request to the routing portion of the rails framework.
  - Three Types : 
   1. Simple match route - `get 'demo/index'`
   2. Default route - `get ':controller(/:action(/:id))'`
   3. Root route - `oot 'demo#index'` Used to route if nothing is written after domain in url. When nothing is there to compare for routing.
   4. Resourcefull route
- erb stands for embeded ruby 
- HTTP Redirect - Server sends a redirect request to the browser agrees to the request and the browser then requests the page to the server to get redirected to that new page.
- **Instance variables** is Used to give our template access to data gathered by the controller. Used to pass data from controller to the view.