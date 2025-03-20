Received: from smtp-42ae.mail.infomaniak.ch (smtp-42ae.mail.infomaniak.ch [84.16.66.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E1C22D7AB
	for <audit@vger.kernel.org>; Thu, 20 Mar 2025 19:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742497680; cv=none; b=VgNTYdkzPUT0KgEvhG9ZSx7teA7+oouTI7BrHulEpiBYoOmd2OT6Grgx+A8zJsy/lUijIbqCh1ty5a7QgbyslO4k7IBeA4p2rKSBvM5XfBZr8mL6L0rgi1zHk68sNxoRQ7foMBHdLHO6bUCXtcK3RlxGi28Qt7V08PTlWtMq35M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742497680; c=relaxed/simple;
	bh=h99UV6dEfyU1k/qyN8ITOEukGniyS56PiLOeR0hdq+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hSOjsSuVfqcPa0qkeF5Sap9L3YYya5ckf8ihAASF3C3ez4+IPR1N0eKIOU1zUTKYh2ojpDUMLrsmKFVegUAB0BIDHSRiYUJxPUJQHYFxCkU7T1yTjTxYh0TKKdq/B+DU5q/D5KCdlaMMuElA6EvXKTdPA8JHCCGwLd7ZT5/KaGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=VYn8Jkqd; arc=none smtp.client-ip=84.16.66.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="VYn8Jkqd"
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ZJZph2c4rzqd3;
	Thu, 20 Mar 2025 20:07:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1742497676;
	bh=DHsZKcdwvCQFfpxw3M74s3cguCDBRVMCrII724HjMEc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VYn8JkqdlM88scdaMCgjPNjpysSJTIAxQKYDM94cbpqcHBN2x/Ru8ozRg1ZBW7rMY
	 8kPfc9k7uR1eKQzvR9qJ8WuW0H0Gw07zRlC1+3JqBpfpisz7o7g3HDaGbBtrgO1hd/
	 qOcACyjs4xuW3zoS8Z37npT0zGR9u6eCtg67LfUA=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4ZJZpg3mjHzCTs;
	Thu, 20 Mar 2025 20:07:55 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Eric Paris <eparis@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Ben Scarlato <akhna@google.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Charles Zaffery <czaffery@roblox.com>,
	Daniel Burgener <dburgener@linux.microsoft.com>,
	Francis Laniel <flaniel@linux.microsoft.com>,
	James Morris <jmorris@namei.org>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Jorge Lucangeli Obes <jorgelo@google.com>,
	Kees Cook <kees@kernel.org>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Phil Sutter <phil@nwl.cc>,
	Praveen K Paladugu <prapal@linux.microsoft.com>,
	Robert Salvet <robert.salvet@roblox.com>,
	Shervin Oloumi <enlightened@google.com>,
	Song Liu <song@kernel.org>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	Tingmao Wang <m@maowtm.org>,
	Tyler Hicks <code@tyhicks.com>,
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v7 20/28] selftests/landlock: Add test for invalid ruleset file descriptor
Date: Thu, 20 Mar 2025 20:07:09 +0100
Message-ID: <20250320190717.2287696-21-mic@digikod.net>
In-Reply-To: <20250320190717.2287696-1-mic@digikod.net>
References: <20250320190717.2287696-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

To align with fs_test's layout1.inval and layout0.proc_nsfs which test
EBADFD for landlock_add_rule(2), create a new base_test's
restrict_self_fd which test EBADFD for landlock_restrict_self(2).

Cc: Günther Noack <gnoack@google.com>
Cc: Paul Moore <paul@paul-moore.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v5:
- New standalone patch (that can be backported).
---
 tools/testing/selftests/landlock/base_test.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
index 7dc431a0e18e..cb13416533d2 100644
--- a/tools/testing/selftests/landlock/base_test.c
+++ b/tools/testing/selftests/landlock/base_test.c
@@ -269,6 +269,17 @@ TEST(restrict_self_checks_ordering)
 	ASSERT_EQ(0, close(ruleset_fd));
 }
 
+TEST(restrict_self_fd)
+{
+	int fd;
+
+	fd = open("/dev/null", O_RDONLY | O_CLOEXEC);
+	ASSERT_LE(0, fd);
+
+	EXPECT_EQ(-1, landlock_restrict_self(fd, 0));
+	EXPECT_EQ(EBADFD, errno);
+}
+
 TEST(ruleset_fd_io)
 {
 	struct landlock_ruleset_attr ruleset_attr = {
-- 
2.49.0

