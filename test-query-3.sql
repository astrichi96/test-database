select count(user_profile.id_user) as "Non-active​ ​Providers" 
from user_profile, user_role 
where (user_profile.id_user=user_role.id_user 
    and user_role.cd_role_type="PROVIDER" 
    and user_role.in_status=0)