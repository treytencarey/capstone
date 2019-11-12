<div id="allNavBar">
	<%@page import = "utils.Utils" %>
	<%@page import="database.Profile" %>
	<%@page import="project.Main" %>
	<%	Profile p;

		try {
			p = new Profile(Integer.parseInt(session.getAttribute("accountPKey").toString()));
		} catch (Exception e) {
			p = new Profile();
		}
	%>

	<% session.setAttribute("curPage", request.getRequestURI() + ((request.getQueryString() != null) ? "?" + request.getQueryString() : "")); %>
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
	  <a class="navbar-brand" href="<%= request.getContextPath() %>/">Omaha Game Jam</a>
	  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
	    <span class="navbar-toggler-icon"></span>
	  </button>

	  <div class="collapse navbar-collapse" id="navbarSupportedContent">
	    <ul class="navbar-nav mr-auto">
	      <li class="nav-item active">
	        <a class="nav-link" href="<%= request.getContextPath() %>/">Home <span class="sr-only">(current)</span></a>
	      </li>
	      <li class="nav-item">
	        <a class="nav-link" href="<%= request.getContextPath() %>/Events">Events</a>
	      </li>
	      <li class="nav-item">
	        <a class="nav-link" href="<%= request.getContextPath() %>/Games">Games</a>
	      </li>
	      <li class="nav-item">
	        <a class="nav-link" href="<%= request.getContextPath() %>/Gallery">Gallery</a>
	      </li>
	      <li class="nav-item">
	        <a class="nav-link" href="<%= request.getContextPath() %>/News">News</a>
	      </li>
	    </ul>
	    <ul class="navbar-nav navbar-right" id="loginUL">
		    <%	if (session.getAttribute("accountPKey") == null) { %>
		    	<li><button id="loginBtn" class="btn btn-link my-2 my-sm-0" name="login"><a id="loginBtn" href="#loginModal" class="trigger-btn" data-toggle="modal">Login</a></button></li>
		    <%	} else { %>
		    	<li>
		    		<button type="button" class="btn btn-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		    			<%= session.getAttribute("accountEmail") %>
		    		</button>
		    		<div id="profileDropdown" class="dropdown-menu dropdown-menu-right">
		    			<a id="addGameBtn" href="#newGameModal" class="dropdown-item" data-toggle="modal">Submit Game</a>
		    			<a class="dropdown-item" href="<%= request.getContextPath() %>/profile?id=<%= session.getAttribute("accountPKey").toString() %>">My Profile</a>
		    			<div class="dropdown-divider"></div>
		    			<form style="padding: .25rem 0;"class="dropdown-item" action = "<%= request.getContextPath() %>/accountServlet" method = "post">
							<!-- <a class="trigger-btn logInOutBtn" name="logout">Logout</a> -->
							<button id="logoutBtn" class="btn btn-link my-2 my-sm-0" name="logout">Logout</button>
						</form>
		    		</div>
		    	</li>
					<!-- <form action = "accountServlet" method = "post">
						<a class="trigger-btn logInOutBtn" name="logout">Logout</a>
						<button id="logoutBtn" class="btn btn-link my-2 my-sm-0" name="logout">Logout</button>
					</form> -->
			<%	} %>
		</ul>
	    <!-- <form class="form-inline my-2 my-lg-0">
	      <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
	      <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
	    </form> -->
	  </div>
	</nav>


	<%@include file="subNavbar.jsp" %>
</div>
<% if (session.getAttribute("message") != null && session.getAttribute("message").toString().length() > 0) { %>
 	   <div style="display: block; margin: auto; text-align: center;">
 	   	${sessionScope.message}
 	   </div>
 	   <br/>
 <% 	session.setAttribute("message", "");
 } %>

<%	if (session.getAttribute("accountPKey") == null) { %>
	<!-- Login Modal HTML -->
	<div id="loginModal" class="modal fade">
		<div class="modal-dialog modal-login">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">Sign In</h4>
	                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				</div>
				<div id="loginModalError" style="display: none;">
					<div style="text-align: center;">
						<a id="loginModalErrorMessage" style="color: red;">Error</a>
					</div>
				</div>
				<div class="modal-body">
					<form id="loginForm">
						<div class="form-group">
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-user"></i></span>
								<input type="email" class="form-control" name="email" placeholder="Email" required="required">
							</div>
						</div>
						<div class="form-group">
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-lock"></i></span>
								<input type="password" class="form-control" name="password" placeholder="Password" required="required">
							</div>
						</div>
						<div class="form-group">
							<input name="loginButton" style="display: none;">
							<button type="submit" class="btn btn-primary btn-block btn-lg">Sign In</button>
						</div>
						<p class="hint-text"><a href="#">Forgot Password?</a></p>
					</form>
				</div>
				<div class="modal-footer"><a href="#registerModal" data-toggle="modal" data-target="#registerModal" data-dismiss="modal">Create account</a></div>
			</div>
		</div>
	</div>
	<% session.setAttribute("servlet", "accountServlet"); %>
	<% session.setAttribute("form", "#loginForm"); %>
	<%@page import="java.util.Arrays" %>
	<% session.setAttribute("updates", Arrays.asList("#loginUL", "#subNavBar")); %>
	<% session.setAttribute("successJS", "$('#loginModal').modal('hide');"); %>
	<% session.setAttribute("errorJS", "document.getElementById('loginModalError').style.display='block'; document.getElementById('loginModalErrorMessage').innerText=request.responseText;"); %>
	<%@include file="components/ajax.jsp" %>

	<!-- Register Modal HTML -->
	<div id="registerModal" class="modal fade">
		<div class="modal-dialog modal-login">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">Register</h4>
	                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				</div>
				<div id="registerModalError" style="display: none;">
					<div style="text-align: center;">
						<a id="registerModalErrorMessage" style="color: red;">Error</a>
					</div>
				</div>
				<div class="modal-body">
					<form id="registerForm" class="needs-validation">
						<div class="form-group">
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-user"></i></span>
								<input id="validationEmail" type="email" class="form-control" name="email" placeholder="Email" required="required">
							</div>
							<label>You can use letters, numbers & periods</label>
						</div>
						<div class="form-group">
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-lock"></i></span>
								<input id="validationPass1" type="password" class="form-control" name="password" placeholder="Password" required="required" pattern="^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$">
								<input id="validationPass2" type="password" class="form-control" name="password2" placeholder="Confirm" required="required" pattern="^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$">
							</div>
							<label>Use 8 or more characters with a mix of letters, numbers & symbols</label>
						</div>
						<div class="form-group">
							<input name="registerButton" style="display: none;">
							<button type="submit" class="btn btn-primary btn-block btn-lg">Register</button>
						</div>
					</form>
				</div>
				<div class="modal-footer"><a href="#loginModal" data-toggle="modal" data-target="#loginModal" data-dismiss="modal">Sign in instead</a></div>
			</div>
		</div>
	</div>
	<% session.setAttribute("servlet", "accountServlet"); %>
	<% session.setAttribute("form", "#registerForm"); %>
	<% session.setAttribute("updates", Arrays.asList("#loginUL", "#subNavBar")); %>
	<% session.setAttribute("successJS", "$('#registerModal').modal('hide');"); %>
	<% session.setAttribute("errorJS", "document.getElementById('registerModalError').style.display='block'; document.getElementById('registerModalErrorMessage').innerText=request.responseText;"); %>
	<%@include file="components/ajax.jsp" %>
<%}%>

<% if (session.getAttribute("accountPKey") != null) { %>
	<!-- New Game Modal HTML -->
	<div id="newGameModal" class="modal fade">
		<div class="modal-dialog modal-login newMods">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">Add New Game</h4>
	                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				</div>
				<div class="modal-body">
					<form class="was-validated" action="<%= request.getContextPath() %>/accountServlet" method = "post">
						<div class="form-group">
							<div class="input-group">
								<span class="input-group-addon icons"><i class="fa fa-gamepad"></i></span>
								<input type="text" class="form-control modalFields" name="title" placeholder="Title" required>
								<div class="invalid-feedback">Please enter a valid game title</div>
							</div>
						</div>
						<div class="form-group">
							<div class="input-group">
								<span class="input-group-addon icons"><i class="fa fa-comment"></i></span>
								<textarea class="form-control modalFields" name="description" placeholder="Description" required></textarea>
								<div class="invalid-feedback">Please enter a valid description</div>
							</div>
						</div>
						<div class="form-group">
							<div class="input-group">
								<span class="input-group-addon icons"><i class="fa fa-upload"></i></span>
							    <input type="file" class="custom-file-input" id="validatedCustomFile1" required>
							    <label class="form-control modalFields custom-file-label" for="validatedCustomFile1">Choose Icon...</label>
							    <div class="invalid-feedback">Please upload a valid icon</div>
						    </div>
					  	</div>


						<!--
						Need to add a for loop here to loop through all the available mutators for the current event!
						Waiting on backend to complete that before adding to frontend!
						 -->
						<fieldset class="form-group">
							<div class="input-group">
								<span class="input-group-addon icons"><i class="fa fa-exclamation"></i></span>
						      	<legend class="col-form-label col-sm-2 pt-0 checkLabel">Mutators</legend>
						      	<div class="col-sm-8 checkForms">
							        <div class="form-check">
						          		<input class="form-check-input" type="checkbox" id="mutatorCheck1">
						        		<label class="form-check-label" for="gridCheck1">
							          		Save ocean
						        		</label>
						        	</div>
						        	<div class="form-check">
							          	<input class="form-check-input" type="checkbox" id="mutatorCheck1">
						        		<label class="form-check-label" for="gridCheck1">
							          		No violence
						        		</label>
						        	</div>
						        	<div class="form-check">
						          		<input class="form-check-input" type="checkbox" id="mutatorCheck1">
						        		<label class="form-check-label" for="gridCheck1">
						          			3 color palette
						        		</label>
						        	</div>
						      	</div>
						    </div>
					    </fieldset>

						<div class="form-group">
							<div class="input-group">
								<span class="input-group-addon icons"><i class="fa fa-upload"></i></span>
							    <input type="file" class="custom-file-input" id="validatedCustomFile2" required>
							    <label class="form-control modalFields custom-file-label" for="validatedCustomFile2">Choose Screenshot(s)...</label>
							    <div class="invalid-feedback">Please upload a valid screenshot(s)</div>
						    </div>
					  	</div>

					  	<fieldset class="form-group">
							<div class="input-group">
								<span class="input-group-addon icons"><i class="fa fa-apple"></i></span>
						      	<legend class="col-form-label col-sm-2 pt-0 checkLabel">System(s)</legend>
							    <div class="col-sm-8 checkForms">
								    <div class="form-check form-check-inline">
									  	<input class="form-check-input" type="checkbox" id="windowsOSCheckbox1" value="windowsOption">
									  	<label class="form-check-label" for="windowsOSCheckbox1">Windows</label>
									</div>
									<div class="form-check form-check-inline">
									  	<input class="form-check-input" type="checkbox" id="macOSCheckbox2" value="macOption">
									  	<label class="form-check-label" for="macOSCheckbox2">Mac</label>
									</div>
									<div class="form-check form-check-inline">
									  	<input class="form-check-input" type="checkbox" id="linuxOSCheckbox" value="linuxOption">
									  	<label class="form-check-label" for="linuxOSCheckbox">Linux</label>
									</div>
								</div>
				  			</div>
			  			</fieldset>

					  	<div class="form-group">
					  		<div class="input-group">
							    <span class="input-group-addon icons"><i class="fa fa-wrench"></i></span>
						      	<legend class="col-form-label col-sm-2 pt-0 checkLabel">Tools</legend>
							    <select multiple class="form-control modalFields" id="inlineFormCustomSelect" required>
									<option value="1">1</option>
									<option value="2">2</option>
									<option value="3">3</option>
									<option value="4">4</option>
								  	<option value="5">5</option>
						    	</select>
					    	</div>
					  	</div>
					  	<div class="form-group">
							<div class="input-group">
								<span class="input-group-addon icons"><i class="fa fa-wrench"></i></span>
						      	<legend class="col-form-label col-sm-2 pt-0 checkLabel">Credits</legend>
						      	<div class="col-sm-8">
									<!-- <input type="text" class="form-control creditField" name="credit" placeholder="Name"> -->
								</div>
							</div>
						</div>

						<div class="form-group">
							<button type="submit" name="newGameButton" class="btn btn-primary btn-block btn-lg">Submit</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
<%}%>

<script src="http://js.nicedit.com/nicEdit-latest.js" type="text/javascript"></script>
<script>
		$(document).ready(function(){
			$("#add-image").click(function(){
				$(".newEventImages").append("<br><span class='input-group-addon icons'><i class='fa fa-upload'></i></span><input type='file' class='custom-file-input' id='validatedCustomFile' required/><label class='form-control modalFields custom-file-label' for='validatedCustomFile'>Choose Image(s)...</label>");
			});
		});

		$(document).ready(function(){
			$("#add-mutator").click(function(){
				$(".newEventMutators").append("<br><span class='input-group-addon icons'><i class='fa fa-exclamation'></i></span><input type='text' class='mutator' placeholder='Mutator' /><input type='text' class='mutator-description' placeholder='Description' />");
			});
		});

		$(document).ready(function(){
			$(".datepicker").datepicker();
		});

</script>

<!-- New Event Modal HTML -->
<div id="newEventModal" class="modal fade">

	<div class="modal-dialog modal-login newMods">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">Create New Event</h4>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			</div>
		</div>
	</div>
<%}%>

<% if (request.getRequestURI().equals(request.getContextPath()+"/profile") && request.getParameter("id").equals(session.getAttribute("accountPKey")))  { %>
	<!-- Edit Profile Modal HTML -->
	<div id="editProfileModal" class="modal fade">
		<div class="modal-dialog modal-login newMods">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">Edit Profile</h4>
	                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				</div>
				<div class="modal-body">
					<div class="profile-img">

                     	<%@page import="java.io.File" %>
                     	<% 	String profileImgPath = "/Uploads/Profiles/Pics/" + session.getAttribute("accountPKey");
                         	if (!new File(Main.context.getRealPath(profileImgPath)).exists())
                     			profileImgPath = "https://middle.pngfans.com/20190511/as/avatar-default-png-avatar-user-profile-clipart-b04ecd6d97b1eb1a.jpg";
                         	else
                         		profileImgPath = request.getContextPath() + profileImgPath;
                     	%>
                         <img style="width: 100%;" src="<%= profileImgPath %>" alt=""/>
                         <div>
                              <form action="/Capstone/filesServlet" method="post" enctype="multipart/form-data">
                              	<label style="width: 100%; color: black;" for="file" class="custom-file-upload">
						    		<i class="fa fa-cloud-upload"></i> Custom Upload
								</label>
								<input id="file" style="display: none;" class="file btn btn-lg btn-primary" name="file" type="file" onchange="this.form.submit()"/>
                             	<!-- <input id="image_uploads" class="file btn btn-lg btn-primary" type="file" name="image_uploads" onchange="this.form.submit()"/> -->
                             	<!-- <input class="btn btn-lg btn-primary" type="submit" value="Update"/> -->
                             </form>
                         </div>
                     </div>
					<form class="was-validated" action="<%= request.getContextPath() %>/profileServlet" method = "post">
						<div class="form-group">
							<div class="input-group">
								<span class="input-group-addon icons"><i class="fa fa-user"></i></span>
								<input type="text" class="form-control modalFields" name="name" placeholder="Full Name" value="<%= p.getName() %>" required>
								<div class="invalid-feedback">Please enter a valid name</div>
							</div>
						</div>
					</div>
					<div class="form-group">
						<div class="input-group">
							<span class="input-group-addon icons"><i class="fa fa-comment"></i></span>
							<textarea class="form-control modalFields" id="eventDescription" name="eventDescription" placeholder="Description" required></textarea>
							<div class="invalid-feedback">Please enter a valid description</div>
						</div>
					</div>

					<div class="form-group">
							<span class="input-group-addon icons"><i class="fas fa-heading"></i></span>
							<textarea id="eventBody" name="eventBody"></textarea>
					</div>

					<div class="form-group">
						<div class="input-group newEventImages">
							<span class="input-group-addon icons"><i class="fa fa-upload"></i></span>
							<input type="file" class="custom-file-input" id="validatedCustomFile" required/>
						    <label class="form-control modalFields custom-file-label" for="validatedCustomFile">Choose Image(s)...</label>
						    <div class="invalid-feedback">Please upload a valid image(s)</div>
					    </div>
					    <input type="button" value="Add another image" id="add-image" />
				  	</div>
				  	<div class="form-group">
						<div class="input-group newEventMutators">
							<span class='input-group-addon icons'><i class='fa fa-exclamation'></i></span>
							<input type='text' class='mutator' placeholder='Mutator' />
							<input type='text' class='mutator-description' placeholder='Description' />

						</div>
						<input type="button" value="Add another mutator" id="add-mutator" /><br><br>
					</div>

				  	<div class="form-group">
				  		<div class="input-group eventDates">
				    	  		<input type="text" class="datepicker" placeholder="Start Date" /><br>
				    	  		<input type="text" class="datepicker" placeholder="End Date" /><br>
				  		</div>
				  	</div>

					<div class="form-group">
						<button type="submit" name="newEventButton" class="btn btn-primary btn-block btn-lg">Submit</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>

<!-- New News Article Modal HTML -->
<div id="newNewsArticleModal" class="modal fade">
	<div class="modal-dialog modal-login newMods">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">Add News Article</h4>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			</div>
			<div class="modal-body">
				<form class="was-validated" action="<%= request.getContextPath() %>/NewsServlet" method = "post">
					<div class="form-group">
						<div class="input-group">
							<span class="input-group-addon icons"><i class="fas fa-newspaper"></i></span>
							<input type="text" class="form-control modalFields" name="newsTitle" placeholder="Title" required>
							<div class="invalid-feedback">Please enter a valid title.</div>
						</div>
					</div>
					<div class="form-group">
						<div class="input-group">
							<span class="input-group-addon icons"><i class="fas fa-heading"></i></span>
							<input type="text" class="form-control modalFields" name="newsHeader" placeholder="Header" required>
							<div class="invalid-feedback">Please enter a valid header.</div>
						</div>
					</div>
					<div class="form-group">
							<span class="input-group-addon icons"><i class="fas fa-heading"></i></span>
							<textarea id="newsBody" name="newsBody"></textarea>
					</div>
					<div class="form-group">
						<div class="input-group">
							<span class="input-group-addon icons"><i class="fa fa-upload"></i></span>
						    <input type="file" class="custom-file-input" id="newsFile" required>
						    <label class="form-control modalFields custom-file-label" for="newsFile">Choose Image(s)...</label>
						    <div class="invalid-feedback">Please upload a valid image.</div>
					    </div>
				  	</div>
				  	<div class="form-group">
					  	<div class="form-check">
	  						<input class="form-check-input" type="checkbox" value="isPublicCheckbox" name="isPublicCheckbox" checked>
	  						<label class="form-check-label">
	    						Make Public
	  						</label>
						</div>
					</div>

					<div class="form-group">
						<button type="submit" id="newNewsArticleButton" name="newNewsArticleButton" class="btn btn-primary btn-block btn-lg">Submit</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
