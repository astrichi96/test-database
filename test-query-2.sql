select count(distinct user_role.id_user) as "Active​ ​Licensees​ ​With​ ​Address​ ​Info" 
from user_role, user_address 
where user_role.cd_role_type = "LICENSEE" or user_role.cd_role_type = "LIMITED" 
          and user_address.id_user = user_role.id_user 
          and user_address.id_address is not null