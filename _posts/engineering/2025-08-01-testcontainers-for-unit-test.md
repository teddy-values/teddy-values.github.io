---
title: Unit Test에서 @TestContainers와 @MockServer 사용하기
date: 2025-08-01 18:53:00 +0900
categories: [Engineering, Test Code]
tags: [engineering]
---

# Unit Test에서 @TestContainers와 @MockServer 사용하기

unit test를 작성할 때 @TestContainers를 사용할 때 고민이 있었던 부분이 있다.

1. @TestContainer 또는 @MockServer에서 application.yaml에서 관리되는 port를 사용하는 것이 적절할까?

아니다. TestContainer, MockServer에서 직접 binding해주는 port를 사용하는 것이 적절하다.
테스트 로직에 따라서 여러번 재시작될 수 있으므로 port는 매번 달라지는 값을 사용할 수 있어야 한다.

2. @TestContainer에서 데이터 충돌이 나는 경우는 어떻게 처리해야할까?

@MockServer는 비교적 가볍게 재시작이 가능하다. 하지만 @TestContainer는 재시작이 어렵다.
여러개의 테스트에서 @TestContainer에 저장된 데이터에 대한 충돌이 발생하는 경우, @TestContainer를 여러개 띄우거나 mockking을 하는 것이 아니라, 각 테스트마다 데이터를 clear하면 충돌을 피할 수 있다.

단순한 방법이지만, UnitTest에서 `비즈니스 로직을 테스트하고 data는 mocking하지 않는다.`의 기준에 따르고 싶지만, 데이터의 충돌이 발생할 때는 데이터의 초기화를 하면 쉽게 해결된다.

# 위의 기준보다 더 중요한 점은

테스트 코드 작성 방법에 절대적인 기준은 없다. 프로젝트 목적, 동료의 의견에따라 맞게 실용적으로 적응할 수 있어야 한다.
