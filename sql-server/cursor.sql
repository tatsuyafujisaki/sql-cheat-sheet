DECLARE @Name sysname;
DECLARE @ObjectId int;

DECLARE Cursor1 CURSOR LOCAL FAST_FORWARD FOR
SELECT name, object_id FROM sys.objects;

OPEN Cursor1;

FETCH NEXT FROM Cursor1
INTO @Name, @ObjectId;

WHILE @@FETCH_STATUS = 0
BEGIN
  SELECT @Name, @ObjectId;
  
  FETCH NEXT FROM Cursor1 INTO @name, @objectId;
END;

CLOSE Cursor1;
DEALLOCATE Cursor1;
