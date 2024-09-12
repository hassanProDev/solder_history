part of 'data_compression_cubit.dart';

@immutable
abstract class DataCompressionState {}

class DataCompressionInitial extends DataCompressionState {}

class GetDataCompressionSuccess extends DataCompressionState {
  final DataCompressionModel data;

  GetDataCompressionSuccess(this.data);
}

class GetDataCompressionFailed extends DataCompressionState {
  final String error;

  GetDataCompressionFailed(this.error);
}

class GetDataCompressionLoading extends DataCompressionState {}

class AddDataCompressionSuccess extends DataCompressionState {}

class AddDataCompressionFailed extends DataCompressionState {}

class AddDataCompressionLoading extends DataCompressionState {}

class DeleteSolderSuccess extends DataCompressionState {}

class DeleteSolderFailed extends DataCompressionState {}

class DeleteSolderLoading extends DataCompressionState {}

class FetchDataCompressionSuccess extends DataCompressionState {}

class FetchDataCompressionFailed extends DataCompressionState {}

class FetchDataCompressionLoading extends DataCompressionState {}

class UpdateDataCompressionSuccess extends DataCompressionState {}

class UpdateDataCompressionFailed extends DataCompressionState {}

class UpdateDataCompressionLoading extends DataCompressionState {}

class RefreshDataCompressionSuccess extends DataCompressionState {}

class RefreshDataCompressionFailed extends DataCompressionState {}

class RefreshDataCompressionLoading extends DataCompressionState {}

class SearchDataCompression extends DataCompressionState {}
