---
title: Unit Test에서 @SpringBootTest 사용하기
date: 2025-08-01 18:53:00 +0900
categories: [Engineering, Test Code]
tags: [engineering]
---

# Unit Test에서 @SpringBootTest 사용하기

unit test를 작성할 때 @SpringBootTest를 사용해도 될까 말까에 대한 고민이 있었다.

고민을 해보았고 아래와 같은 기준으로 @SpringBootTest를 사용하기로 결정했다.

- application.yaml 같은 외부 설정 파일을 로딩하는 과정은 테스트 범위에서 벗어나기 때문에 런타임과 동일하게 로딩한다.
- 비즈니스 로직에 대한 단위 테스트를 작성할 때에는 data에 대한 mocking을 최소화하고 비즈니스 로직에 집중한다.
- adapter.out 중에서 Redis, RDB에 대한 Bean은 @TestContainer를 사용해서 실제 Bean을 사용한다.
- adapter.out 중에서 외부 서버에 대한 의존성을 가지는 Bean은 mocking하여 테스트한다.

# 위의 기준보다 더 중요한 점은

테스트 코드 작성 방법에 절대적인 기준은 없다. 프로젝트 또는 동료의 의견에 따라 목적에 맞게 실용적으로 적응할 수 있어야 한다.
