const dbName = 'accounts.db';
const tableName = 'Accounts';
const amountcolumn = 'Amount';
const descridecolumn = 'Description';
const daycolumn = 'Date';
const monthcolumn = 'Month';
const yearcolumn = 'Year';
const hourcolumn = 'Hour';
const minutescolumn = 'Minutes';
const statuscolumn = 'Status';
const createTable = '''CREATE TABLE IF NOT EXISTS "Accounts" (
	"Amount"	INTEGER,
	"Description"	TEXT,
	"Date"	INTEGER,
  "Month"	INTEGER,
  "Year"	INTEGER,
  "Hour"	INTEGER,
  "Minutes"	INTEGER,
	"Status"	INTEGER
);''';

const totalBalance = 'TOTAL BALANCE';
