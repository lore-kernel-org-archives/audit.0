Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FC91E89C
	for <audit@vger.kernel.org>; Wed, 22 Oct 2025 23:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761176231; cv=none; b=ooBqa0whVnBxRl6obpYT5Jg37vN73U+4VP70YDaViPvUnSuZC1FNuZH8AWBJDp4Cb/Dr4RdsbJb7s7IV8n2+dF3ggXOaO73ettkWXJviBp1zACVK5QcQG8HmuBmVy8VDlUBgkxIVZYk99SatkzZj9p8hQWNKQKTrILBbwWuwxes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761176231; c=relaxed/simple;
	bh=57buDysdL5sxmUdoozQE8GM3r+UEJBmlZ8BGPKwrcPo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=bVw3thnWQnGmYs74XvtAM3+/eyaX2JmoXJJx7o42bJo6FM39YzD6tm8SilboR3ZMJWfbz7noNj+7mW6NSHxmpiOCd/0L+LXVMz78Ea9ZvwuTrqVI0fg2mghM+laOPSAsKTQqg/Eg+0WKHoDAYT8AVbmYHHF/7+EZN2Wn4/UF8YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=TxzDUB8Q; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="TxzDUB8Q"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-33c4252c3c5so204310a91.0
        for <audit@vger.kernel.org>; Wed, 22 Oct 2025 16:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1761176228; x=1761781028; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+vzx3YfEgODit35kwID2YHYbG7QMR5Zpkug6HiYUF/w=;
        b=TxzDUB8QMXLZ5WaeWmSbC/8AHszUoJOTBGXewFwQYNqDlQ9Nkg6fYz5LGzGhDwVzoD
         rbZnuQNtlO6TvI2WZnCbxEpdl5aeed9xvHCZI+8nOpklV/gycCI+XaWE9vlDDYWC+rQH
         tPbT/7IBUh9zNQ97RX13WrGwq8IkoQ+doqyHjAo0Qm0opA2KHdRvBjM3e4aV1RBg6Euq
         4TVlItYAjCWwIGWzAZQ556Kbe0N6r8zqxKd17YlG1aiS9nVBtwfQDO8V+o1N+egdbDWR
         qEMM0wk0wDrdRfxBuMYzpTz76HLackgN2HVcGmJ3kycpMyxy7hYiQJj7GYhYKD4sPvMI
         7cQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761176228; x=1761781028;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+vzx3YfEgODit35kwID2YHYbG7QMR5Zpkug6HiYUF/w=;
        b=bgunTnKqLzGnpfuHzqAPu6gGnyDdvw0LxlHDFYMvSrpuKhT5LaDazXeXk4nElpV6lf
         9YcZ58759XKq70j2d9roCakEKJXyPKQZXo3nfrOoVpdnWWoRwVL9XgR+NbKSDYDQItTD
         ppx3gOCyDnA6DhGUX1Emi66pLhfK0G0HTbE1414LDjlVyOmI9Qc45NeUtpCHKEr9ABCg
         pr4S+vsMdTDHI80QbZye3+4wxe3qw0ZljhBEz8oZ8WjBnQiaEXa9UqRHdQAwlc/x7Dsg
         mVbDKazMXihDG26ozkTSYWl47UVwMKy0PlCq94i/1ARxBO/9tnTzemjFcw16mXbN9Df6
         zk5w==
X-Gm-Message-State: AOJu0YzFSG4skYz/mHU6gInG8n1o20NEeGGDMbfDttx/yDsNR+Ir9JXS
	Hr6m2aGVAy9mLx8JJ2FdiRRGaEfGnnLplXuSqpIXPBqtQkfD+01FhSodivkEhlKygv0gXKkl/mq
	XiVxyrAzeJLFv4AlwCisnUHojjUEufxWK5iYrM0BG0fZyxpNX+JOHIeNu
X-Gm-Gg: ASbGncu3RJT6GZdkIOhd8qlhKD8PxTM9F15WE7sQ9Amgc94a8JLslY7y2kBWdvzSANE
	2rDqS2y73mVXyW241jnqsLGf/yRlOFUTDkTxOkXYzA+Z1jTpG4WQVqftEjFT18kYfUgJ6vI3P0X
	mi9X6K1KU+4otKDHGHm0ImWU7zilwUnVxcqz2MDAKxYqcziMatR74fARXEWXozBQCciBn1wSSH8
	nNpnj2rYwo/6WlZW7fKyJlQT2iTv/qJoOgRbIw8PVDWstjEUebVRSxZmmyj
X-Google-Smtp-Source: AGHT+IGAjNLduYGBYemBdc+hnmIfpSe9bAyzJEElDahtTjD9CXxFS+1B7ENfGrTpJnZtEuGTvbNDZE0sfPh7cxcLZeQ=
X-Received: by 2002:a17:90b:1b0b:b0:32b:cafc:e339 with SMTP id
 98e67ed59e1d1-33fafc8ad20mr788570a91.36.1761176228505; Wed, 22 Oct 2025
 16:37:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 22 Oct 2025 19:36:56 -0400
X-Gm-Features: AS18NWB142q9Zgmp9TMZqrYvFDDmbZ0R0xmjhI5gFZYuw9o7pTNG8OxZthEzd94
Message-ID: <CAHC9VhRRpv8Hve=YzdTcRWHC-gmXtLN+k0oX9wP3ifPSyfQ27w@mail.gmail.com>
Subject: audit/dev rebased to v6.18-rc2
To: audit@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

A quick note to let you know that I rebased the audit/dev branch to
v6.18-rc2 to pick up the fix below (it was impacting my testing).
This shouldn't affect any outstanding work, or yet-to-be-reviewed
patches, I just wanted to let everyone know as this is a change from
the usual.

https://lore.kernel.org/netdev/20251015052715.4140493-1-edumazet@google.com/

If anyone has any questions, or concerns, please let me know.

-- 
paul-moore.com
