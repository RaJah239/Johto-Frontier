CategoryNames:
	dw .Physical
	dw .Special
	dw .Other

.Physical: db "<physical>Physical@"
.Special:  db "<special>Special @"
.Other:    db "<other>Other   @"

BattleCategoryNames:
	dw .Physical
	dw .Special
	dw .Other

.Physical: db "<physical>@"
.Special:  db "<special>@"
.Other:    db "<other>@"
