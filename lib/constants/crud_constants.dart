// database file name
const dbName = 'accounts.db';
// table names
const nodetable = 'Accounts';
const usertable = 'User';
const catagorytable = 'Catagory';
const subcatagorytable = 'SubCatagory';
// create table commands tables
const accountTable = '''CREATE TABLE IF NOT EXISTS "Accounts" (
	"id"	INTEGER NOT NULL UNIQUE,
	"Amount"	INTEGER NOT NULL,
	"UserId"	INTEGER NOT NULL,
	"CatagoryId"	INTEGER,
	"SubCatagoryId"	INTEGER,
	"Date"	INTEGER NOT NULL,
	"Month"	INTEGER NOT NULL,
	"Year"	INTEGER NOT NULL,
	"Hour"	INTEGER NOT NULL,
	"Minutes"	INTEGER NOT NULL,
	"IsIncome"	INTEGER NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("UserId") REFERENCES "user"("id") ON DELETE CASCADE,
	FOREIGN KEY("SubCatagoryId") REFERENCES "Sub Catagory"("id") ON DELETE SET NULL,
	FOREIGN KEY("CatagoryId") REFERENCES "Catagory"("id") ON DELETE SET NULL
);''';

const userTable = '''CREATE TABLE IF NOT EXISTS "user" (
	"id"	INTEGER NOT NULL UNIQUE,
	"UserName"	TEXT NOT NULL,
	"Info"	TEXT NOT NULL,
	"ImagePath"	TEXT,
	"IsActive"	INTEGER NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);''';

const catagoryTable = '''CREATE TABLE IF NOT EXISTS "Catagory" (
	"id"	INTEGER NOT NULL UNIQUE,
	"UserId"	INTEGER NOT NULL,
	"CatagoryName"	INTEGER NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("UserId") REFERENCES "user"("id") ON DELETE CASCADE
);''';

const subCatagoryTable = '''CREATE TABLE IF NOT EXISTS "SubCatagory" (
	"id"	INTEGER NOT NULL UNIQUE,
	"CatagoryId"	INTEGER NOT NULL,
	"CatagoryName"	TEXT NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("CatagoryId") REFERENCES "user"("id") ON DELETE CASCADE
);''';
// column names
const idcolumn = 'id';
const amountcolumn = 'Amount';
const userIdcolumn = 'UserId';
const catagoryIdcolumn = 'CatagoryId';
const subcatagoryIdcolumn = 'SubCatagoryId';
const datecolumn = 'Date';
const monthcolumn = 'Month';
const yearcolumn = 'Year';
const hourcolumn = 'Hour';
const minutescolumn = 'Minutes';
const isIncomecolumn = 'IsIncome';

const namecolumn = 'UserName';
const infocolumn = 'Info';
const imageColumn = 'ImagePath';
const isactivecolumn = 'IsActive';

const catagorynamecolumn = 'CatagoryName';
