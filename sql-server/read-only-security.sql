--
-- Server level
--

-- Print logins
sp_helplogins;
sp_helplogins <login>;

-- Print server roles
sp_helpsrvrole;
sp_helpsrvrole <server role>;

-- Print mappings between server roles and logins
sp_helpsrvrolemember;
sp_helpsrvrolemember <server role>;

-- Print principals (logins, server roles, etc)
SELECT * FROM sys.server_principals;

-- Print server roles of a given login
SELECT SUSER_NAME(role_principal_id)
FROM sys.server_role_members
WHERE SUSER_NAME(member_principal_id) = 'sa';

-- Print server logins of a given role
SELECT SUSER_NAME(member_principal_id)
FROM sys.server_role_members
WHERE SUSER_NAME(role_principal_id) = 'sysadmin';

--
-- Database level
--

-- Print databases
sp_helpdb;
sp_helpdb Database1;

-- Print users in the current database
sp_helpuser;
sp_helpuser User1;

-- Print fixed database roles in the current database
sp_helpdbfixedrole;
sp_helpdbfixedrole <fixed database role>;

-- Print database roles in the current database
sp_helprole;
sp_helprole <database role>;

-- Print mappings between database roles and users in the current database
sp_helprolemember;
sp_helprolemember <database role>;

-- Print database roles of a given user in the current database
SELECT USER_NAME(role_principal_id)
FROM sys.database_role_members
WHERE USER_NAME(member_principal_id) = 'dbo';

-- Print database users of a given role in the current database
SELECT USER_NAME(member_principal_id)
FROM sys.database_role_members
WHERE USER_NAME(role_principal_id) = 'db_owner';
