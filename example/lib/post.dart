import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:custom_mapper_annotation/custom_mapper_annotation.dart';

part 'post.freezed.dart';
part 'post.mapper.dart';

@freezed
sealed class Tag with _$Tag {
  const factory Tag({required String name, required int popularity}) = _Tag;
}

@freezed
sealed class Comment with _$Comment {
  const factory Comment({required String author, required String text}) =
      _Comment;
}

@freezed
sealed class Post with _$Post {
  const factory Post({
    required String title,
    required String content,
    required List<Tag> tags,
    required List<Comment> comments,
  }) = _Post;
}

@freezed
@Mapper(domain: Post, toDomain: true, toData: true)
sealed class PostData with _$PostData {
  const factory PostData({
    required String title,
    required String content,
    required List<TagData> tags,
    required List<CommentData> comments,
  }) = _PostData;
}

@freezed
@Mapper(domain: Tag, toDomain: true, toData: true)
sealed class TagData with _$TagData {
  const factory TagData({required String name, required int popularity}) =
      _TagData;
}

@freezed
@Mapper(domain: Comment, toDomain: true, toData: true)
sealed class CommentData with _$CommentData {
  const factory CommentData({required String author, required String text}) =
      _CommentData;
}
