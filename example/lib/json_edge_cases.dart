import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:custom_mapper_annotation/custom_mapper_annotation.dart';
import 'json_models.dart';
import 'json_cross_file_test.dart';
import 'json_complex_cross_file.dart';

part 'json_edge_cases.freezed.dart';
part 'json_edge_cases.g.dart';
part 'json_edge_cases.map.dart';

/// Edge case 1: Circular references between files with JSON annotations
@freezed
sealed class Department with _$Department {
  const factory Department({
    @JsonKey(name: 'dept_id') required String deptId,
    @JsonKey(name: 'dept_name') required String deptName,
    @JsonKey(name: 'employees_list') required List<Employee> employeesList,
    @JsonKey(name: 'manager_info') required Employee? managerInfo,
  }) = _Department;

  factory Department.fromJson(Map<String, dynamic> json) =>
      _$DepartmentFromJson(json);
}

@freezed
sealed class Employee with _$Employee {
  const factory Employee({
    @JsonKey(name: 'emp_id') required String empId,
    @JsonKey(name: 'emp_name') required String empName,
    @JsonKey(name: 'dept_reference') required Department? deptReference,
    @JsonKey(name: 'contact_details')
    required CustomerInfo contactDetails, // Cross-file reference
  }) = _Employee;

  factory Employee.fromJson(Map<String, dynamic> json) =>
      _$EmployeeFromJson(json);
}

@freezed
@Mapper(domain: Department, toDomain: true, toData: true)
sealed class DepartmentData with _$DepartmentData {
  const factory DepartmentData({
    @JsonKey(name: 'dept_id') required String deptId,
    @JsonKey(name: 'dept_name') required String deptName,
    @JsonKey(name: 'employees_list') required List<EmployeeData> employeesList,
    @JsonKey(name: 'manager_info') required EmployeeData? managerInfo,
  }) = _DepartmentData;

  factory DepartmentData.fromJson(Map<String, dynamic> json) =>
      _$DepartmentDataFromJson(json);
}

@freezed
@Mapper(domain: Employee, toDomain: true, toData: true)
sealed class EmployeeData with _$EmployeeData {
  const factory EmployeeData({
    @JsonKey(name: 'emp_id') required String empId,
    @JsonKey(name: 'emp_name') required String empName,
    @JsonKey(name: 'dept_reference') required DepartmentData? deptReference,
    @JsonKey(name: 'contact_details')
    required CustomerInfoData contactDetails, // Cross-file reference
  }) = _EmployeeData;

  factory EmployeeData.fromJson(Map<String, dynamic> json) =>
      _$EmployeeDataFromJson(json);
}

/// Edge case 2: Multiple levels of nesting with JSON transformations
@freezed
sealed class Organization with _$Organization {
  const factory Organization({
    @JsonKey(name: 'org_id') required String orgId,
    @JsonKey(name: 'org_name') required String orgName,
    @JsonKey(name: 'departments_list')
    required List<Department> departmentsList,
    @JsonKey(name: 'headquarters_address')
    required Address headquartersAddress, // Cross-file reference
    @JsonKey(name: 'payment_settings')
    required PaymentMethod paymentSettings, // Cross-file reference
  }) = _Organization;

  factory Organization.fromJson(Map<String, dynamic> json) =>
      _$OrganizationFromJson(json);
}

@freezed
@Mapper(domain: Organization, toDomain: true, toData: true)
sealed class OrganizationData with _$OrganizationData {
  const factory OrganizationData({
    @JsonKey(name: 'org_id') required String orgId,
    @JsonKey(name: 'org_name') required String orgName,
    @JsonKey(name: 'departments_list')
    required List<DepartmentData> departmentsList,
    @JsonKey(name: 'headquarters_address')
    required AddressData headquartersAddress, // Cross-file reference
    @JsonKey(name: 'payment_settings')
    required PaymentMethodData paymentSettings, // Cross-file reference
  }) = _OrganizationData;

  factory OrganizationData.fromJson(Map<String, dynamic> json) =>
      _$OrganizationDataFromJson(json);
}

/// Edge case 3: Generic types with cross-file references and JSON annotations
@freezed
sealed class DataContainer with _$DataContainer {
  const factory DataContainer({
    @JsonKey(name: 'container_id') required String containerId,
    @JsonKey(name: 'metadata_info') required Map<String, dynamic> metadataInfo,
    @JsonKey(name: 'audit_trail') required List<AuditEntry> auditTrail,
  }) = _DataContainer;

  factory DataContainer.fromJson(Map<String, dynamic> json) =>
      _$DataContainerFromJson(json);
}

@freezed
sealed class AuditEntry with _$AuditEntry {
  const factory AuditEntry({
    @JsonKey(name: 'entry_id') required String entryId,
    @JsonKey(name: 'action_performed') required String actionPerformed,
    @JsonKey(name: 'user_details')
    required CustomerInfo userDetails, // Cross-file reference
    @JsonKey(name: 'timestamp_utc') required DateTime timestampUtc,
  }) = _AuditEntry;

  factory AuditEntry.fromJson(Map<String, dynamic> json) =>
      _$AuditEntryFromJson(json);
}

@freezed
@Mapper(domain: AuditEntry, toDomain: true, toData: true)
sealed class AuditEntryData with _$AuditEntryData {
  const factory AuditEntryData({
    @JsonKey(name: 'entry_id') required String entryId,
    @JsonKey(name: 'action_performed') required String actionPerformed,
    @JsonKey(name: 'user_details')
    required CustomerInfoData userDetails, // Cross-file reference
    @JsonKey(name: 'timestamp_utc') required DateTime timestampUtc,
  }) = _AuditEntryData;

  factory AuditEntryData.fromJson(Map<String, dynamic> json) =>
      _$AuditEntryDataFromJson(json);
}
