- Always run `bundle install` again after every modifications to the gemfile.
- Out of MVC architecture, Views and Controllers must interact with Browser at each request. Models can be optional for once.
- BVC is an essential triangle.
- Routing : If rails cant find a matching doc in the public folder then it send the request to the routing portion of the rails framework.
  - Three Types : 
   1. Simple match route - `get 'demo/index'`
   2. Default route - `get ':controller(/:action(/:id))'`
   3. Root route - `oot 'demo#index'` Used to route if nothing is written after domain in url. When nothing is there to compare for routing.
   4. Resourcefull route