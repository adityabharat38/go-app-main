from locust import HttpUser, between, task

class GoAppUser(HttpUser):
    wait_time = between(1, 5)  # Simulate users waiting between requests
    
    # def on_start(self):
        # Define any setup tasks such as logging in
        # self.client.post("/login", {
        #     "username": "test_user",
        #     "password": "test_password"
        # })

    @task
    def view_courses(self):
        # Simulate a user visiting the /courses endpoint
        self.client.get("/courses")

    @task
    def view_home(self):
        # Simulate a user visiting the home page
        self.client.get("/home")

    @task
    def view_contact(self):
        # Simulate a user visiting the contact page
        self.client.get("/contact")

    @task
    def view_about(self):
        # Simulate a user visiting the about page
        self.client.get("/about")
