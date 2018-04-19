SELECT user_role.cd_role_type as User_Type, cnt_activos.cnt as Total​_​Active, users.cnt as No​_Middle_​Name 
FROM   (select id_user, SUM(if(nm_last is null, 1, 0)) as cnt from user_profile group by id_user) as users, 
        user_role, 
        (select cd_role_type, count(id_user) as cnt from user_role where in_status = 1 group by cd_role_type) as cnt_activos 
WHERE user_role.in_status = 1 
        and user_role.id_user = users.id_user 
        and cnt_activos.cd_role_type = user_role.cd_role_type 
        group by user_role.cd_role_type, No​_Middle​_Name