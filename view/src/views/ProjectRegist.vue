<template>
		<div>
			<v-container align="center">	
				<v-card flat>
				<v-card-title class="justify-center"><h1 style="color:#333333">Projectの詳細を登録</h1></v-card-title>
				</v-card>
				<v-row>
					<v-col cols="2"></v-col>
					<v-col cols="8">
						<v-text-field
							label = "project name"
							background-color = "white"
							v-model = "projectName"
						></v-text-field>
						<br>
								<v-form>
								<v-select
									v-model="clientNum"
									:reduce="(optjions) => options.id"
									key="id"
									label = "clientの数"
									:items = "[1,2,3,4,5]"
									:menu-props="{
										top: true,
										offsetY: true,
									}"
									item-text="id"
									item-value="id"
									outlined
								/>
							</v-form>
							<v-form v-for="i in clientNum" :key="i">
								<v-card elevation="7" :class="`rounded-xl`">					
									<v-row>
										<v-col cols="2" />
										<v-col cols="8">
											<v-text-field
												v-model="clients[i]"
												class="pt-5"
												key="id"
												label="client name"
												outlined
											></v-text-field>

											<v-select
												v-model="$data['issueNum'+i]"
												:reduce="(optjions) => options.id"
												key="id"
												label = "issueの数"
												:items = "[1,2,3,4,5]"
												:menu-props="{
													top: true,
													offsetY: true,
												}"
												item-text="id"
												item-value="id"
												outlined
											/>
											<v-form v-for="j in $data['issueNum'+i]" :key="j">
												<v-card elevation="7" :class="`rounded-xl`">
													<v-row>
														<v-col cols="2" />
														<v-col cols="8">
															<v-text-field
																class="pt-7"
																v-model="$data['issueName' + i + j ]"
																:reduce="(optjions) => options.id"
																key="id"
																label="issue name"
																:items="issues"
																:menu-props="{
																	top: true,
																	offsetY: true,
																}"
																item-text="name"
																item-value="id"
																outlined
															></v-text-field>
															<v-text-field
																v-model="$data['issueDescription'+i  + j]"
																:reduce="(optjions) => options.id"
																key="id"
																label="issue description"
																:items="issues"
																:menu-props="{
																	top: true,
																	offsetY: true,
																}"
																item-text="name"
																item-value="id"
																outlined
															></v-text-field>
															<v-select
																v-model="$data['issueLevel' + i + j]"
																:reduce="(optjions) => options.id"
																key="id"
																label = "issueのlevel"
																:items = "[1,2,3,4,5]"
																:menu-props="{
																	top: true,
																	offsetY: true,
																}"
																item-text="id"
																item-value="id"
																outlined
															/>
														</v-col>
													<v-col cols="2" />
													</v-row>
												</v-card>
												<br>
												<br>
											</v-form>
										</v-col>
										<v-col cols="2" />
									</v-row>
								</v-card>
								<br />
								<br />
							</v-form>
					
						<br>
						<v-btn 
							text 
							rounded
							large 
							color="btn"
							class="pr-4 font-weight-bold"
							to = /tree
							@click="register"
							>登録
			</v-btn>
					</v-col>
				</v-row>
			</v-container>
		</div>
</template>

<script>
import axios from 'axios'
export default {
	data() {
		return {
			user:[],
			userId:[],
			projectName: [],
			projectId: [],
			clientNum: [],
			clients: [],
			clientId: [],
			issueNum: [],
			issueNumber: [
        {id: 1},
        {id: 2},
        {id: 3},
        {id: 4},
        {id: 5},
      ],

			issueName11: [],
			issueName12: [],
			issueName13: [],
			issueName14: [],
			issueName15: [],

			issueName21: [],
			issueName22: [],
			issueName23: [],
			issueName24: [],
			issueName25: [],

			issueName31: [],
			issueName32: [],
			issueName33: [],
			issueName34: [],
			issueName35: [],

			issueName41: [],
			issueName42: [],
			issueName43: [],
			issueName44: [],
			issueName45: [],

			issueName51: [],
			issueName52: [],
			issueName53: [],
			issueName54: [],
			issueName55: [],

			issueNum1: [],
			issueNum2: [],
			issueNum3: [],
			issueNum4: [],
			issueNum5: [],

			issueDescription11: [],
			issueDescription12: [],
			issueDescription13: [],
			issueDescription14: [],
			issueDescription15: [],

			issueDescription21: [],
			issueDescription22: [],
			issueDe6ion23: [],
			issueDescription24: [],
			issueDescription25: [],

			issueDescription31: [],
			issueDescription32: [],
			issueDescription33: [],
			issueDescription34: [],
			issueDescription35: [],

			issueDescription41: [],
			issueDescription42: [],
			issueDescription43: [],
			issueDescription44: [],
			issueDescription45: [],

			issueDescription51: [],
			issueDescription52: [],
			issueDescription53: [],
			issueDescription54: [],
			issueDescription55: [],

			issueLevel11: [],
			issueLevel12: [],
			issueLevel13: [],
			issueLevel14: [],
			issueLevel15: [],

			issueLevel21: [],
			issueLevel22: [],
			issueLevel23: [],
			issueLevel24: [],
			issueLevel25: [],

			issueLevel31: [],
			issueLevel32: [],
			issueLevel33: [],
			issueLevel34: [],
			issueLevel35: [],

			issueLevel41: [],
			issueLevel42: [],
			issueLevel43: [],
			issueLevel44: [],
			issueLevel45: [],

			issueLevel51: [],
			issueLevel52: [],
			issueLevel53: [],
			issueLevel54: [],
			issueLevel55: [],
		};
	},

methods : {
	register: async function() {
		//projectの登録
		if (this.projectName){
			var projectParams = {
				name: this.projectName,
			}
			await this.addProject(projectParams);
		}

		const url = process.env.VUE_APP_URL + '/project_users'
			var params = {
				project_id: this.projectId,
				user_id: this.userId
			}
				await axios.post(url,params,{
				headers: {
							'Content-Type': 'application/json',
							'access-token': localStorage.getItem('access-token'),
							'client': localStorage.getItem('client'),
							'uid': localStorage.getItem('uid')
						}
				}
			);
	
		for (let i = 1; i < this.clients.length; i++){
				console.log(this.clients[i]);
					var clientparams = {
						name: this.clients[i],
						project_id: this.projectId
					}
				await this.addClient(clientparams);

				for(let j =0; j < this.issueNum1; j++){
					if (j==0){
						var issueparams11 ={
							name: this.issueName11,
							client_id: this.clientId,
							user_id: this.userId,
							description: this.issueDescription11,
							level: this.issueLevel11
						}
						await this.addIssue(issueparams11)
					}	
					else if (j==1){
						var issueparams12 ={
							name: this.issueName12,
							client_id: this.clientId,
							user_id: this.userId,
							description: this.issueDescription112,
							level: this.issueLevel12
						}
						await this.addIssue(issueparams12)
					}
					else if (j==2){
						var issueparams13 ={
							name: this.issueName13,
							client_id: this.clientId,
							user_id: this.userId,
							description: this.issueDescription113,
							level: this.issueLevel13
						}
						await this.addIssue(issueparams13)
					}
					else if (j==3){
						var issueparams14 ={
							name: this.issueName14,
							client_id: this.clientId,
							user_id: this.userId,
							description: this.issueDescription114,
							level: this.issueLevel14
						}
						await this.addIssue(issueparams14)
					}
					else if (j==4){
						var issueparams15 ={
							name: this.issueName15,
							client_id: this.clientId,
							user_id: this.userId,
							description: this.issueDescription115,
							level: this.issueLevel15
						}
						await this.addIssue(issueparams15)
					}
				}
				for(let j =0; j < this.issueNum2; j++){
					if (j==0){
						var issueparams21 ={
							name: this.issueName21,
							client_id: this.clientId,
							user_id: this.userId,
							description: this.issueDescription21,
							level: this.issueLevel21
						}
						await this.addIssue(issueparams21)
					}	
					else if (j==1){
						var issueparams22 ={
							name: this.issueName22,
							client_id: this.clientId,
							user_id: this.userId,
							description: this.issueDescription122,
							level: this.issueLevel22
						}
						await this.addIssue(issueparams22)
					}
					else if (j==2){
						var issueparams23 ={
							name: this.issueName23,
							client_id: this.clientId,
							user_id: this.userId,
							description: this.issueDescription123,
							level: this.issueLevel23
						}
						await this.addIssue(issueparams23)
					}
					else if (j==3){
						var issueparams24 ={
							name: this.issueName24,
							client_id: this.clientId,
							user_id: this.userId,
							description: this.issueDescription124,
							level: this.issueLevel24
						}
						await this.addIssue(issueparams24)
					}
					else if (j==4){
						var issueparams25 ={
							name: this.issueName25,
							client_id: this.clientId,
							user_id: this.userId,
							description: this.issueDescription125,
							level: this.issueLevel25
						}
						await this.addIssue(issueparams25)
					}
				}
				for(let j =0; j < this.issueNum3; j++){
					if (j==0){
						var issueparams31 ={
							name: this.issueName31,
							client_id: this.clientId,
							user_id: this.userId,
							description: this.issueDescription31,
							level: this.issueLevel31
						}
						await this.addIssue(issueparams31)
					}	
					else if (j==1){
						var issueparams32 ={
							name: this.issueName32,
							client_id: this.clientId,
							user_id: this.userId,
							description: this.issueDescription132,
							level: this.issueLevel32
						}
						await this.addIssue(issueparams32)
					}
					else if (j==2){
						var issueparams33 ={
							name: this.issueName33,
							client_id: this.clientId,
							user_id: this.userId,
							description: this.issueDescription133,
							level: this.issueLevel33
						}
						await this.addIssue(issueparams33)
					}
					else if (j==3){
						var issueparams34 ={
							name: this.issueName34,
							client_id: this.clientId,
							user_id: this.userId,
							description: this.issueDescription134,
							level: this.issueLevel34
						}
						await this.addIssue(issueparams34)
					}
					else if (j==4){
						var issueparams35 ={
							name: this.issueName35,
							client_id: this.clientId,
							user_id: this.userId,
							description: this.issueDescription135,
							level: this.issueLevel35
						}
						await this.addIssue(issueparams35)
					}
				}
				for(let j =0; j < this.issueNum4; j++){
					if (j==0){
						var issueparams41 ={
							name: this.issueName41,
							client_id: this.clientId,
							user_id: this.userId,
							description: this.issueDescription41,
							level: this.issueLevel41
						}
						await this.addIssue(issueparams41)
					}	
					else if (j==1){
						var issueparams42 ={
							name: this.issueName42,
							client_id: this.clientId,
							user_id: this.userId,
							description: this.issueDescription142,
							level: this.issueLevel42
						}
						await this.addIssue(issueparams42)
					}
					else if (j==2){
						var issueparams43 ={
							name: this.issueName43,
							client_id: this.clientId,
							user_id: this.userId,
							description: this.issueDescription143,
							level: this.issueLevel43
						}
						await this.addIssue(issueparams43)
					}
					else if (j==3){
						var issueparams44 ={
							name: this.issueName44,
							client_id: this.clientId,
							user_id: this.userId,
							description: this.issueDescription144,
							level: this.issueLevel44
						}
						await this.addIssue(issueparams44)
					}
					else if (j==4){
						var issueparams45 ={
							name: this.issueName45,
							client_id: this.clientId,
							user_id: this.userId,
							description: this.issueDescription145,
							level: this.issueLevel45
						}
						await this.addIssue(issueparams45)
					}
				}
				for(let j =0; j < this.issueNum5; j++){
					if (j==0){
						var issueparams51 ={
							name: this.issueName51,
							client_id: this.clientId,
							user_id: this.userId,
							description: this.issueDescription51,
							level: this.issueLevel51
						}
						await this.addIssue(issueparams51)
					}	
					else if (j==1){
						var issueparams52 ={
							name: this.issueName52,
							client_id: this.clientId,
							user_id: this.userId,
							description: this.issueDescription152,
							level: this.issueLevel52
						}
						await this.addIssue(issueparams52)
					}
					else if (j==2){
						var issueparams53 ={
							name: this.issueName53,
							client_id: this.clientId,
							user_id: this.userId,
							description: this.issueDescription153,
							level: this.issueLevel53
						}
						await this.addIssue(issueparams53)
					}
					else if (j==3){
						var issueparams54 ={
							name: this.issueName54,
							client_id: this.clientId,
							user_id: this.userId,
							description: this.issueDescription154,
							level: this.issueLevel54
						}
						await this.addIssue(issueparams54)
					}
					else if (j==4){
						var issueparams55 ={
							name: this.issueName55,
							client_id: this.clientId,
							user_id: this.userId,
							description: this.issueDescription155,
							level: this.issueLevel55
						}
						await this.addIssue(issueparams55)
					}
				}
		}
	},

	addProject: async function (params) {
		const url = process.env.VUE_APP_URL + '/projects'
		await axios.post(url,params,{
		headers: {
					'Content-Type': 'application/json',
					'access-token': localStorage.getItem('access-token'),
					'client': localStorage.getItem('client'),
					'uid': localStorage.getItem('uid')
				}}).then(
						(response) => {
							console.log("projectIdの取得")
							this.posts = response.data.posts
							console.log(response)
							this.projectId = response.data.id
							console.log(this.projectId)
						}
				)
	},


	addClient: async function (clientparams) {
		const url = process.env.VUE_APP_URL + '/clients'
		await axios.post(url,{ client: clientparams},{
					headers: {
						'Content-Type': 'application/json',
						'access-token': localStorage.getItem('access-token'),
						'client': localStorage.getItem('client'),
						'uid': localStorage.getItem('uid')
					}})
					.then(
						(response) =>{
							console.log("clientIdの取得")
							this.posts =response.data.posts
							console.log(response)
							this.clientId = response.data.id
							console.log(this.clientId)
						}
					);
	},



	addIssue: async function (issueparams) {
		const url = process.env.VUE_APP_URL + '/issues'
		await axios.post(url,{ issue: issueparams},{
					headers: {
						'Content-Type': 'application/json',
						'access-token': localStorage.getItem('access-token'),
						'client': localStorage.getItem('client'),
						'uid': localStorage.getItem('uid')
					}})
					.then(
						(response) =>{
							this.posts =response.data.posts
							console.log(response)
						}
					);
	},
},
	mounted(){
		const url = process.env.VUE_APP_URL;
		axios
		.get(url + "/api/v1/users/show", {
        headers: {
          "Content-Type": "application/json",
          "access-token": localStorage.getItem("access-token"),
          client: localStorage.getItem("client"),
          uid: localStorage.getItem("uid"),
        },
      })
      .then((response) => {
        this.user = JSON.parse(JSON.stringify(response.data.data));
				console.log(this.user)
				this.userId = this.user.id
				console.log(this.userId)
      });
    axios
      .get(url + "/api/v1/get_project_user", {
        headers: {
          "Content-Type": "application/json",
          "access-token": localStorage.getItem("access-token"),
          client: localStorage.getItem("client"),
          uid: localStorage.getItem("uid"),
        },
      })
      .then((response) => {
        this.userProjects = response.data;
      });
	}
};

</script>,