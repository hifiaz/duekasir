import 'package:due_kasir/model/item_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
sealed class CartEvent extends Equatable {
  const CartEvent();
}

final class CartStarted extends CartEvent {
  @override
  List<Object> get props => [];
}

final class CartItemAdded extends CartEvent {
  const CartItemAdded(this.item);

  final ItemModel item;

  @override
  List<Object> get props => [item];
}

final class CartItemRemoved extends CartEvent {
  const CartItemRemoved(this.item);

  final ItemModel item;

  @override
  List<Object> get props => [item];
}

final class CartPaid extends CartEvent {
  @override
  List<Object> get props => [];
}