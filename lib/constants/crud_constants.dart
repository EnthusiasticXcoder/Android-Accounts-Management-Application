const dbName = 'accounts.db';
const tableName = 'Accounts';
const idcolumn = 'id';
const amountcolumn = 'Amount';
const descridecolumn = 'Description';
const daycolumn = 'Date';
const monthcolumn = 'Month';
const yearcolumn = 'Year';
const hourcolumn = 'Hour';
const minutescolumn = 'Minutes';
const isIncomecolumn = 'Status';
const createTable = '''CREATE TABLE IF NOT EXISTS "Accounts" (
  "id"	INTEGER NOT NULL,
	"Amount"	INTEGER,
	"Description"	TEXT,
	"Date"	INTEGER,
  "Month"	INTEGER,
  "Year"	INTEGER,
  "Hour"	INTEGER,
  "Minutes"	INTEGER,
	"Status"	INTEGER,
  PRIMARY KEY("id" AUTOINCREMENT)
);''';

const totalBalance = 'TOTAL BALANCE';
