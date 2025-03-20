Received: from smtp-bc0f.mail.infomaniak.ch (smtp-bc0f.mail.infomaniak.ch [45.157.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9775622DFA0
	for <audit@vger.kernel.org>; Thu, 20 Mar 2025 19:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742497681; cv=none; b=PWNN5A9+h5sALrbbh0Xq0dpfbFqmSSvcJSyQVRNn1VrNFKcyGUTQvtJp2GvLyc2tmmyaH91bE/RPCdT57q0fbP9JtxqTUy7BPmngHFLkdWDYWXmyThMhPPBljsKDFaRxdlkoZYJpULb3XCE7J7GSSGwGUZchPJC3fZdCHPoS4Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742497681; c=relaxed/simple;
	bh=5wSp16PzXW25jQHwWtDQzWvXn57TRsLbcOkap5zElVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UBqL/vs7NtEC/JsEKMTa7wYmp2uPsZQrrZxARS1NTF+QFswZGQ6W6VknwMLvPwrL/bFrLTqc6MUZ0a/prrWQifcpcDNmCtLWk8qmvA8gMH0i3m2poqmvHKP8Yi0dYtks7banOWjJBphJlaYcqYa3+GRY981H/960b/6MlMJneQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=OKU40taV; arc=none smtp.client-ip=45.157.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="OKU40taV"
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10:40ca:feff:fe05:0])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ZJZpj6vvwzK0k;
	Thu, 20 Mar 2025 20:07:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1742497677;
	bh=74ouMiX4giVyHf7pbwBfSsgmdEoGD0LYiGig71u+SKs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OKU40taVi3Xur8MFY6eJFnaXshLfzl9O/lEZ5Mjvy55raWDnZZSFx7AzPuz0HeGDL
	 tw9Zmcr/dWVeQX3mfR6ty6yoeLlhuV5hgoDuQ1CoHExYRJrp5aNRtxdeFP0RiXrn4/
	 LFr0jMHe3CGEQVF2TaqmNiVjZs771w5i+UrbrFj4=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4ZJZpj0Rv9z6P6;
	Thu, 20 Mar 2025 20:07:57 +0100 (CET)
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
Subject: [PATCH v7 21/28] selftests/landlock: Extend tests for landlock_restrict_self(2)'s flags
Date: Thu, 20 Mar 2025 20:07:10 +0100
Message-ID: <20250320190717.2287696-22-mic@digikod.net>
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

Add the base_test's restrict_self_fd_flags tests to align with previous
restrict_self_fd tests but with the new
LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF flag.

Add the restrict_self_flags tests to check that
LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF,
LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON, and
LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF are valid but not the next
bit.  Some checks are similar to restrict_self_checks_ordering's ones.

Cc: Günther Noack <gnoack@google.com>
Cc: Paul Moore <paul@paul-moore.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v5:
- Rename restrict flags.
- Update LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF test to pass with -1
  as ruleset FD, and flag ordering.
- Add restrict_self_fd_flags tests.

Changes since v4:
- Update with LANDLOCK_RESTRICT_SELF_QUIET_SUBDOMAINS, and
  LANDLOCK_RESTRICT_SELF_LOG_CROSS_EXEC.

Changes since v3:
- Use a last_flag variable.

Changes since v2:
- New patch.
---
 tools/testing/selftests/landlock/base_test.c | 71 ++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
index cb13416533d2..c75ac925b912 100644
--- a/tools/testing/selftests/landlock/base_test.c
+++ b/tools/testing/selftests/landlock/base_test.c
@@ -280,6 +280,77 @@ TEST(restrict_self_fd)
 	EXPECT_EQ(EBADFD, errno);
 }
 
+TEST(restrict_self_fd_flags)
+{
+	int fd;
+
+	fd = open("/dev/null", O_RDONLY | O_CLOEXEC);
+	ASSERT_LE(0, fd);
+
+	/*
+	 * LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF accepts -1 but not any file
+	 * descriptor.
+	 */
+	EXPECT_EQ(-1, landlock_restrict_self(
+			      fd, LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF));
+	EXPECT_EQ(EBADFD, errno);
+}
+
+TEST(restrict_self_flags)
+{
+	const __u32 last_flag = LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF;
+
+	/* Tests invalid flag combinations. */
+
+	EXPECT_EQ(-1, landlock_restrict_self(-1, last_flag << 1));
+	EXPECT_EQ(EINVAL, errno);
+
+	EXPECT_EQ(-1, landlock_restrict_self(-1, -1));
+	EXPECT_EQ(EINVAL, errno);
+
+	/* Tests valid flag combinations. */
+
+	EXPECT_EQ(-1, landlock_restrict_self(-1, 0));
+	EXPECT_EQ(EBADF, errno);
+
+	EXPECT_EQ(-1, landlock_restrict_self(
+			      -1, LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF));
+	EXPECT_EQ(EBADF, errno);
+
+	EXPECT_EQ(-1,
+		  landlock_restrict_self(
+			  -1,
+			  LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF |
+				  LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF));
+	EXPECT_EQ(EBADF, errno);
+
+	EXPECT_EQ(-1,
+		  landlock_restrict_self(
+			  -1,
+			  LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON |
+				  LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF));
+	EXPECT_EQ(EBADF, errno);
+
+	EXPECT_EQ(-1, landlock_restrict_self(
+			      -1, LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON));
+	EXPECT_EQ(EBADF, errno);
+
+	EXPECT_EQ(-1,
+		  landlock_restrict_self(
+			  -1, LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF |
+				      LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON));
+	EXPECT_EQ(EBADF, errno);
+
+	/* Tests with an invalid ruleset_fd. */
+
+	EXPECT_EQ(-1, landlock_restrict_self(
+			      -2, LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF));
+	EXPECT_EQ(EBADF, errno);
+
+	EXPECT_EQ(0, landlock_restrict_self(
+			     -1, LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF));
+}
+
 TEST(ruleset_fd_io)
 {
 	struct landlock_ruleset_attr ruleset_attr = {
-- 
2.49.0

