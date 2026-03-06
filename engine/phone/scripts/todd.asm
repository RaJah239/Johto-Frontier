ToddPhoneCalleeScript:
	gettrainername STRING_BUFFER_3, CAMPER, TODD
	farscall PhoneScript_AnswerPhone_Male
	checkflag ENGINE_GOLDENROD_DEPT_STORE_SALE_IS_ON
	iftrue .SaleOn
	farsjump ToddNoItemScript

.SaleOn:
	farsjump ToddHurryScript

ToddPhoneCallerScript:
	gettrainername STRING_BUFFER_3, CAMPER, TODD
	farscall PhoneScript_GreetPhone_Male
.ToddDeptStoreSale:
	setflag ENGINE_GOLDENROD_DEPT_STORE_SALE_IS_ON
	farsjump ToddItemScript
