Respond_with
======================
	When you generate a scaffold in Rails, you’ll see the usual respond_to blocks:

    def create
	    @product = Product.new(product_params)
		respond_to do |format|
	      if @product.save
	        format.html { redirect_to @product, notice: 'Task was successfully created.' }
	        format.json { render :show, status: :created, location: @product }
	      else
	        format.html { render :new }
	        format.json { render json: @product.errors, status: :unprocessable_entity }
	      end
	    end
	end

	This is not very DRY, We can use respond_with method: 

    def create
	    @product = Product.new(product_params)
	    
	    if @product.save
	      flash[:notice] = 'Product was successfully created.'
	    end
	    respond_with(@product)
	end
	
	This is a lot cleaner than the scaffolds Rails comes with. It abstract the boilerplate responding code so that the controller 
	becomes much simpler. The entire respond_to block is now gone, abstracted away in the respond_with method, which does the 
	right response behavior, depending on the state of the object given to it and the action in which it is called. 
	This new controller is smaller and easier to read.	
	We can set flash messages in respond_with by including responders :flash at the top of your controller
	Also the format: respond_to :html, :json

	However, in Rails 4.2, there’s a catch: respond_with is no longer included. We you can get it back if you install the responders gem. 

	Usually, though, each action in your controller will work with the same formats. If index responds to json, so will new, and create, 
	and everything else. So it’d be nice if you could have a respond_with that would affect the entire controller. 


respond_with or respond_to?
==============

	If you want to return different information for different formats, you have a few options. The controller-level respond_to 
	combined with respond_with is a great way to get short controllers. But it tends to help the most when all of your controller 
	actions respond to the same format, and act in the way Rails expects them to.

	Sometimes, though, you want to be able to have a few actions that act differently. The one-liner respond_to is great for handling that situation.

	If you need more control, use the full respond_to with a block, and you can handle each format however you want.

	When we try the format we don't support, like index.txt, we could get the error like this: Missing template products/index,
	This is a wrong error and can confuse clients. We can add the respond_to block to improve: 
	
		respond_to do |format|
	      format.html
	      format.json
	    end
    
    	or DRY way: respond_to :html, :json
	
		If this was a UnknownFormat error, you could return a better response code. Instead, these errors will get mixed together with other, 
		unrelated errors, and it’ll be really hard to handle them.	Then we get 406 error: 

			Started GET "/products.xml" for ::1 at 2015-09-27 20:54:04 +1000
			Processing by ProductsController#index as XML
			Completed 406 Not Acceptable in 10ms (ActiveRecord: 0.0ms)
