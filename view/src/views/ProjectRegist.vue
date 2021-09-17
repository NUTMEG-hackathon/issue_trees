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
							v-model = "project_name"
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
												v-model="clientName"
												class="pt-5"
												:reduce="(optjions) => options.id"
												key="id"
												label="client name"
												:items="clients"
												:menu-props="{
													top: true,
													offsetY: true,
												}"
												item-text="name"
												item-value="id"
												outlined
											></v-text-field>

											<v-select
												v-model="issueNum"
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
											<v-form v-for="i in issueNum" :key="i">
												<v-card elevation="7" :class="`rounded-xl`">
													<v-row>
														<v-col cols="2" />
														<v-col cols="8">
															<v-text-field
																class="pt-7"
																v-model="issueName"
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
																v-model="issueDescription"
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
																v-model="issueLevel"
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
							@click="register"
							>完了
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
			clientName: [],
			clientNum: [],
			issueName: [],
			issueNum: []
		};
	},
	mounted() {
		const url = "http://localhost:3000" + "/api/v1/users/index";
		axios
			.get(url, {
				headers: {
					"Content-Type": "application/json",
					"access-token": localStorage.getItem("access-token"),
					client: localStorage.getItem("client"),
					uid: localStorage.getItem("uid"),
				},
			})
			.then((response) => {
				this.users = response.data.data;
				console.log(this.users)
			});
	},
	methods: {
	
		}
};

</script>