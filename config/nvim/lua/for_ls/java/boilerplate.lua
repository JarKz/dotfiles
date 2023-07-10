local C = {}
local M = {}

C.web = {[[<?xml version="1.0" encoding="UTF-8"?>]],
[[<web-app version="6.0"]],
[[         xmlns="https://jakarta.ee/xml/ns/jakartaee"]],
[[         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"]],
[[         xsi:schemaLocation="https://jakarta.ee/xml/ns/jakartaee https://jakarta.ee/xml/ns/jakartaee/web-app_6_0.xsd">]],
[[</web-app>]]}

C.beans = {[[<?xml version="1.0" encoding="UTF-8"?>]],
[[<beans xmlns="https://jakarta.ee/xml/ns/jakartaee"]],
[[       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"]],
[[       xsi:schemaLocation="https://jakarta.ee/xml/ns/jakartaee https://jakarta.ee/xml/ns/jakartaee/beans_4_0.xsd"]],
[[       bean-discovery-mode="annotated"]],
[[       version="4.0">]],
[[</beans>]]}

C["faces-config"] = {[[<?xml version='1.0' encoding='UTF-8'?>]],
[[<faces-config xmlns="https://jakarta.ee/xml/ns/jakartaee"]],
[[              xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"]],
[[              xsi:schemaLocation="https://jakarta.ee/xml/ns/jakartaee https://jakarta.ee/xml/ns/jakartaee/web-facesconfig_4_0.xsd"]],
[[              version="4.0">]],
[[</faces-config>]]}

C.persistence = {[[<?xml version="1.0" encoding="UTF-8"?>]],
[[<persistence version="3.0" xmlns="https://jakarta.ee/xml/ns/persistence"]],
[[             xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"]],
[[             xsi:schemaLocation="https://jakarta.ee/xml/ns/persistence https://jakarta.ee/xml/ns/persistence/persistence_3_0.xsd">]],
[[</persistence>]]}

function M.get_code(group_name)
	if C[group_name] == nil then
		return ""
	end
	return C[group_name]
end

return M
