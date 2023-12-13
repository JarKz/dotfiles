local C = {}
local M = {}

C.web = { [[<?xml version="1.0" encoding="UTF-8"?>]],
  [[<web-app version="6.0"]],
  [[         xmlns="https://jakarta.ee/xml/ns/jakartaee"]],
  [[         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"]],
  [[         xsi:schemaLocation="https://jakarta.ee/xml/ns/jakartaee https://jakarta.ee/xml/ns/jakartaee/web-app_6_0.xsd">]],
  [[</web-app>]] }

C.beans = { [[<?xml version="1.0" encoding="UTF-8"?>]],
  [[<beans xmlns="https://jakarta.ee/xml/ns/jakartaee"]],
  [[       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"]],
  [[       xsi:schemaLocation="https://jakarta.ee/xml/ns/jakartaee https://jakarta.ee/xml/ns/jakartaee/beans_4_0.xsd"]],
  [[       bean-discovery-mode="annotated"]],
  [[       version="4.0">]],
  [[</beans>]] }

C["faces-config"] = { [[<?xml version='1.0' encoding='UTF-8'?>]],
  [[<faces-config xmlns="https://jakarta.ee/xml/ns/jakartaee"]],
  [[              xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"]],
  [[              xsi:schemaLocation="https://jakarta.ee/xml/ns/jakartaee https://jakarta.ee/xml/ns/jakartaee/web-facesconfig_4_0.xsd"]],
  [[              version="4.0">]],
  [[</faces-config>]] }

C.persistence = { [[<?xml version="1.0" encoding="UTF-8"?>]],
  [[<persistence version="3.0" xmlns="https://jakarta.ee/xml/ns/persistence"]],
  [[             xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"]],
  [[             xsi:schemaLocation="https://jakarta.ee/xml/ns/persistence https://jakarta.ee/xml/ns/persistence/persistence_3_0.xsd">]],
  [[</persistence>]] }

C["hibernate"] = { [[<?xml version = "1.0" encoding = "utf-8"?>]],
  [[<!DOCTYPE hibernate-configuration SYSTEM]],
  [["http://www.hibernate.org/dtd/hibernate-configuration-3.0.dtd">]],
  [[<hibernate-configuration>]],
  [[  <session-factory>]],
  [[    <property name = "hibernate.dialect">]],
  [[       org.hibernate.dialect.MySQLDialect]],
  [[    </property>]],
  [[    <property name = "hibernate.connection.driver_class">]],
  [[       com.mysql.jdbc.Driver]],
  [[    </property>]],
  [[    <!-- Assume test is the database name -->]],
  [[    <property name = "hibernate.connection.url">]],
  [[       jdbc:mysql://localhost/test]],
  [[    </property>]],
  [[    <property name = "hibernate.connection.username">]],
  [[       root]],
  [[    </property>]],
  [[    <property name = "hibernate.connection.password">]],
  [[       root123]],
  [[    </property>]],
  [[    <!-- List of XML mapping files -->]],
  [[    <mapping resource = "Employee.hbm.xml"/>]],
  [[  </session-factory>]],
  [[</hibernate-configuration>]] }

function M.get_groups()
  local groups = {}
  local i = 0
  for name, _ in pairs(C) do
    i = i + 1
    groups[i] = name
  end
  return groups
end

function M.get_code(group_name)
  if C[group_name] == nil then
    return ""
  end
  return C[group_name]
end

return M
