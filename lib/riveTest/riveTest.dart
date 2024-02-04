import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class riveTest extends StatelessWidget {
  const riveTest({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: RiveAnimation.network(
          'https://opencvtestmain931da04b00a94538b68685b4d5e11082185547-dev.s3.ap-northeast-1.amazonaws.com/public/Rive/anime_girl.riv?AWSAccessKeyId=ASIAXCBJJE42AMXTMF6X&Expires=1706863647&Signature=a%2F2%2BZetgnrrHApRnbsPc9ohpJ1I%3D&x-amz-security-token=IQoJb3JpZ2luX2VjEJH%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEaDmFwLW5vcnRoZWFzdC0xIkcwRQIgbj8IWtgWkP2ziw5ghj7aRbHBqKBoL5CQhrnDtQMcQM8CIQCSoOYflcPU0mzgRmwEqlDu4qgQxBdrq3jrI1Nq3g1PniriBAhaEAAaDDQ4NTQxNzg4NzU0MCIMbIYDzthljsYeSwDhKr8EV0PcLE2nlE%2BD329G12c9FwkEt0mmfu4NPE0Np6AIWeXif9NPHD%2B25glCkWDGpKZcyAN2d2y084o96rqweqEaDpZzqGnoeHNXDGm2SCA3P1FYE%2FqHsFjfYFj1OTSgylpBlXNB8vm%2FYpywR%2FGQ2EEBRwOvZb%2FNGG54iVQp3Yg%2BwOlx%2FWuCjjOZIqiqqT6Qufz4TroYTv7VtuqRKt7gCM1lusdy9SRse664GH1tMwOVq2V1uCAVTBYJMD5m0YHzqsW8icTiagqQUWCNcTp2Ca%2FQqyAGDyDJnPARMUwmX5hm0TJdJAy3vy0f7psJPOwt%2F%2FyadFwQZlriEZjFStijsC4CW9JyV1VRB7wbiVQ3%2Foh74xKqSx3RwVpkK4TTJZubBMDe1Q80NOyBuXoC4Y5pm0Cs6Lq8tAu7IO7SMi%2BRQw9t9fXnHtUD9wrlQmeVfGkAkGwwuJIN7uoaIoaufMlK94HR%2FsWjoqOBJZp1bXFiTfIBSSBHIpnZG11qeEVBwAhH8CesGvDePdVHBY%2B6Rp1hKuJbYt47C22uaAQAcfQBH18VIpMQZebTtvnYk1oZZR3VNb0SVW6mpNV5mVN7OixzFZcIv7lYh3OIwhiDbhDEyNTxgttDuNwa2MGJjVgRaUsJ%2FKznBD3TyNI%2Fj0xLiRys8iQsfiRdJ9aLsVavANt83COR047W%2F%2FJ%2BRRqtIidM7QsD%2BXSQjLldYm6L6wpFgOmM73uCGiMI%2BMSE78wrdrWNSye1s5tICNtXCaeJfE%2BuzPhJltUwvtXyrQY6hQKD3IEm9O51uNtTn0A2mkc%2BDtE8KBb6shPyaobbxKSYSxCoVStEmMp30k7NMnp1vSHK%2BXWQeMcvtodYT3asyV8sva%2Fa07FW9f5XtsIiR0o7e3n0c1JtUwvYmx6RkD9kDCk9DlKjH9p6F%2BThhP5qFAJlJTiCOWAmTryOhPgO76Qm1yvz3520V8yHWScidheXqilVrNDGDX6aExb1pSuKCsFBjU7GkgrmBHau%2Bpmxco44Edo%2BK2QtSMEnRYwyOlR6xhtVfVpeeJvd2cqg7jlo8k%2F86bQ%2B7bthT%2FfD8Sb%2Bygnj5IRpCeckQqZr7JY2ZgehBIN%2FGYV1Qebl6WEssYzWGkPUnVzytRM%3D',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
