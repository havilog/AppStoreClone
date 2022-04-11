# AppStoreClone

AppStore의 검색 화면을 SwiftUI, Combine, TCA, async/await를 활용하여 구현해보자

- Swift version: 5.5
- Xcode version: 13.3
- tuist version: 3.0.1

## 실행 방법

1. tuist가 설치가 안되어있다면 다음 명령어로 tuist 설치

```
curl -Ls https://install.tuist.io | bash
```

2. tuist generate로 프로젝트 파일 생성

cc. tuist version이 다르면 .. tuist edit 에서 manifest file에서 잡아주면 되는거 같은데 안해봐서 모름

## 요구사항

1. 앱 스토어 검색화면 구현
2. 키워드 입력 시 검색결과 리스트로 표출
3. 이미지 캐싱 및 페이지네이션 구현
4. 셀 클릭 시 디테일로 이동
