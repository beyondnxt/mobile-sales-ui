import 'dart:async';

import 'package:sales_app/features/auth/domain/entities/login_entity/login_entity.dart';
import 'package:sales_app/features/companies/data/models/companies_remote_response_model/company_model.dart';
import 'package:sales_app/features/companies/domain/entities/company_reponse_mapper_to_entity/company_entity_mapper.dart';
import 'package:sales_app/features/companies/domain/entities/company_response_entity/feedback_entity.dart';
import 'package:sales_app/features/companies/domain/entities/company_response_entity/order_entity.dart';
import 'package:sales_app/features/expense/domain/entities/expense_response_entity/expense_entity.dart';
import 'package:sales_app/features/products/domain/entities/product_response_entity/product_entity.dart';

class AppLocalDatabase {
  // static Store? _store;

  static List<ExpenseEntity> expenseList = [
    const ExpenseEntity(
      expense: "500 Rs",
      date: "11-05-2024",
    ),
    const ExpenseEntity(
      expense: "1000 Rs",
      date: "30-05-2024",
    ),
    const ExpenseEntity(
      expense: "4000 Rs",
      date: "11-05-2021",
    ),
  ];
  addExpense(ExpenseEntity expense) {
    expenseList.add(expense);
    return true;
  }

  List<ExpenseEntity> getAllExpense() {
    return expenseList;
  }

  Future<LoginSuccessEntity?> login() async {
    return Future.value(LoginSuccessEntity());
  }

  static List<OrderEntity> orders = [
    const OrderEntity(
      statusOfProcessing: "Processing",
      createdBy: "Kumar S",
      orderNumber: 1234,
      orderCreatedDate: "12-03-2024",
    ),
    const OrderEntity(
      statusOfProcessing: "Completed",
      createdBy: "John Doe",
      orderNumber: 5678,
      orderCreatedDate: "15-03-2024",
    ),
    const OrderEntity(
      statusOfProcessing: "Pending",
      createdBy: "Alice Smith",
      orderNumber: 91011,
      orderCreatedDate: "18-03-2024",
    ),
    const OrderEntity(
      statusOfProcessing: "Processing",
      createdBy: "Emily Brown",
      orderNumber: 121314,
      orderCreatedDate: "21-03-2024",
    ),
    const OrderEntity(
        statusOfProcessing: "Processing",
        createdBy: "Pradeep S",
        orderNumber: 1234,
        orderCreatedDate: "31-03-2024"),
  ];
  addOrder(OrderEntity order) {
    orders.add(order);
    return true;
  }

  List<OrderEntity> getOrders() {
    return orders;
  }

  List<ProductEntity> dummyProducts = [
    const ProductEntity(
      name: "Product 1",
      weight: "100 gm",
      totalPrice: "₹ 50",
      unitPrice: "₹ 10",
      quantity: 5,
      totalUnitPrice: "₹ 50",
    ),
    const ProductEntity(
      name: "Product 2",
      weight: "200 gm",
      totalPrice: "₹ 60",
      unitPrice: "₹ 15",
      quantity: 4,
      totalUnitPrice: "₹ 60",
    ),
    const ProductEntity(
      name: "Product 3",
      weight: "150 gm",
      totalPrice: "₹ 45",
      unitPrice: "₹ 9",
      quantity: 5,
      totalUnitPrice: "₹ 45",
    ),
    const ProductEntity(
      name: "Product 4",
      weight: "180 gm",
      totalPrice: "₹ 72",
      unitPrice: "₹ 18",
      quantity: 4,
      totalUnitPrice: "₹ 72",
    ),
    const ProductEntity(
      name: "Product 5",
      weight: "120 gm",
      totalPrice: "₹ 40",
      unitPrice: "₹ 8",
      quantity: 5,
      totalUnitPrice: "₹ 40",
    ),
    const ProductEntity(
      name: "Product 6",
      weight: "250 gm",
      totalPrice: "₹ 80",
      unitPrice: "₹ 16",
      quantity: 5,
      totalUnitPrice: "₹ 80",
    ),
    const ProductEntity(
      name: "Product 7",
      weight: "170 gm",
      totalPrice: "₹ 68",
      unitPrice: "₹ 17",
      quantity: 4,
      totalUnitPrice: "₹ 68",
    ),
    const ProductEntity(
      name: "Product 8",
      weight: "300 gm",
      totalPrice: "₹ 90",
      unitPrice: "₹ 18",
      quantity: 5,
      totalUnitPrice: "₹ 90",
    ),
  ];

  addProducts(ProductEntity order) {
    dummyProducts.add(order);
    return true;
  }

  List<ProductEntity> getProducts() {
    return dummyProducts;
  }

  static List<FeedbackEntity> feedbacks = [
    const FeedbackEntity(
      statusOfProcessing: "Processing",
      createdBy: "Kumar S",
      feedBackDescription:
          "Feddback from Kumar S Lorum ipsum products placeth order it the correct order to display the shop products",
      orderCreatedDate: "12-03-2024",
    ),
    const FeedbackEntity(
      statusOfProcessing: "Completed",
      createdBy: "John Doe",
      feedBackDescription:
          "Feedback from John Doe. Lorum ipsum dolor sit amet, consectetur adipiscing elit. Nulla convallis libero et massa gravida, ac eleifend sapien viverra.",
      orderCreatedDate: "15-03-2024",
    ),
    const FeedbackEntity(
      statusOfProcessing: "Pending",
      createdBy: "Alice Smith",
      feedBackDescription:
          "Feedback from Alice Smith. Duis auctor tempus mi vitae pellentesque. Integer nec leo vitae ligula gravida vestibulum. Quisque eget est sed urna posuere blandit.",
      orderCreatedDate: "18-03-2024",
    ),
    const FeedbackEntity(
      statusOfProcessing: "Processing",
      createdBy: "Emily Brown",
      feedBackDescription:
          "Feedback from Emily Brown. Fusce euismod libero et fringilla feugiat. Vestibulum tincidunt, ante id tincidunt volutpat, arcu magna ullamcorper urna, id interdum metus mi eget sapien.",
      orderCreatedDate: "21-03-2024",
    ),
    const FeedbackEntity(
        statusOfProcessing: "Processing",
        createdBy: "Kanam S",
        feedBackDescription:
            "Feddback from Kumar S Lorum ipsum products placeth order it the correct order to display the shop products",
        orderCreatedDate: "31-03-2024"),
  ];

  addFeedback(FeedbackEntity order) {
    feedbacks.add(order);
    return true;
  }

  List<FeedbackEntity> getFeedbacks() {
    return feedbacks;
  }

  static Future<AppLocalDatabase> create() async {
    return AppLocalDatabase();
  }

  int? insert<T>(T object) {
    return null;

    // final Box<T>? box = _store?.box<T>();
    // return box?.put(object);
  }

  List<CompanyDataMapperToEntity>? getAll<T>() {
    var data = (rawData['companies'] as List<dynamic>)
        .map((data) => Company.fromJson(data).mapToEntity())
        .toList();
    return data;

    // final Box<T>? box = _store?.box<T>();
    // return box?.getAll();
  }

  Map rawData = {
    "companies": [
      {
        "company_name": "ABC Corporation",
        "address": "123 Main Street, City, Country",
        "phone_number": 0982347832
      },
      {
        "company_name": "XYZ Industries",
        "address": "456 Elm Street, Town, Country",
        "phone_number": 8923409384
      },
      {
        "company_name": "Sample Ltd.",
        "address": "789 Oak Street, Village, Country",
        "phone_number": 7823203942
      },
      {
        "company_name": "Tech Solutions Inc.",
        "address": "101 Pine Street, Suburb, Country",
        "phone_number": 9988776655
      }
    ]
  };
}
