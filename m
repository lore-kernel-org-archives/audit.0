Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C7B33858F;
	Tue, 17 Feb 2026 13:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771335235; cv=none; b=dHh07gdklKhnpRFpP3NBdFdz4zK2YaxxhZTWjg4uZGO00eJtXnJol5E0uHQkXvjigXe/GxDUBNFXC8YHG9NBFs2xgHGNJll/0ZXq4zQUrsVGrqJVYf5WnrM2vL+8SchdHqdR97JvtjChAPFsQljIru5ycW8lm5bPSlrmCvfibm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771335235; c=relaxed/simple;
	bh=MR79fEnLYLqIryzttYSlgcV9xM6BU8m7T1AIjCutYS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bPd1eXVED6hI2Ix1snEdB1YvHcOKcKHfJ3RHhAVJ1X3O3jfD0ZRNLUI7vCUcMbsYb0XboCADTPf+mJNM8PuBZBdMUsl4q1P7IBDWFVJIxsUj2f3DBwYB5LIzZvl2SlOp/5enSxQkLkZAn5CTRS7hlDGuzpQWfv5FPBB1ABtOFvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hyJlhxXR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hyJlhxXR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BA85C4CEF7;
	Tue, 17 Feb 2026 13:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771335234;
	bh=MR79fEnLYLqIryzttYSlgcV9xM6BU8m7T1AIjCutYS4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hyJlhxXRWtKTdMqlsKUAhlrnrtAYOyMnYbveehzjmYXFNysoZrHNe6yoUL5EuHhhy
	 5HWisklKtDxxAJgeSNZT+n9JM5BVpB5q8tn4o22eDU7sGStDNoreKHyK0diTcy7TU9
	 1aaS3jOIEHqXPsp8SKqJnBqGD2Gc7flG8ykUOV+WQ479Q+yP0HOYOqwPZ5+EtoY5+C
	 CapcodbXxkle/iRo1PHWabr9neqtBJAdOKV9a3xhgnAs/7mOSB/dd/Z+u9Yp7fEJuD
	 cbQAhoTwIP4+kAKRD8XM3mA9v+MwS2/Tv64uP6wQuUtOWMIt2AegCTG5hQ0MebTUIV
	 ydtsKLy/pYVPg==
Date: Tue, 17 Feb 2026 14:33:50 +0100
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Waiman Long <llong@redhat.com>, 
	Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>, linux-kernel@vger.kernel.org, 
	audit@vger.kernel.org, Richard Guy Briggs <rgb@redhat.com>, 
	Ricardo Robaina <rrobaina@redhat.com>
Subject: Re: [PATCH v2] audit: Avoid excessive dput/dget in audit_context
 setup and reset paths
Message-ID: <20260217-fortsetzen-razzia-11771992d348@brauner>
References: <590a36e6-8d11-411a-8fcd-d93eef96f0e9@redhat.com>
 <20260203215002.GI3183987@ZenIV>
 <20260203232634.GJ3183987@ZenIV>
 <6661f966-5235-49ca-bf1f-d1ae2ae32f0d@redhat.com>
 <20260204062614.GK3183987@ZenIV>
 <46d5c480-87d0-4f6a-bcc2-6c936c87e216@redhat.com>
 <20260204201815.GP3183987@ZenIV>
 <cbaab46e-715d-4d06-80af-320caec7feb7@redhat.com>
 <20260205052202.GQ3183987@ZenIV>
 <CAGudoHFz1QZdYTp=PbAF+v-3-EZhwL0PQz+Zv0nNTG0WCSAdAw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHFz1QZdYTp=PbAF+v-3-EZhwL0PQz+Zv0nNTG0WCSAdAw@mail.gmail.com>

On Thu, Feb 05, 2026 at 06:53:34PM +0100, Mateusz Guzik wrote:
> On Thu, Feb 5, 2026 at 6:20 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > Mateusz: *is* there a measurable effect?  Because if there isn't, I'm
> > very tempted to simply revert that thing.  "Churn of adding fs_struct.h
> > as needed" is not the problem - try "exposing the object internals to
> > far larger subset of the kernel".  We had interesting bugs with weird
> > shit deciding to poke in there, locking and refcounting be damned.
> 
> This one I did not bother benchmarking as it is an obvious change --
> read a var directly instead of going through a func call.
> 
> If this is causing trouble then it definitely needs to be reverted,
> but any woes only speak to the mess in the header files.

Any reason this isn't just stealing the cred.h trick?

diff --git a/include/linux/fs_struct.h b/include/linux/fs_struct.h
index 0070764b790a..e8b8d073f9e0 100644
--- a/include/linux/fs_struct.h
+++ b/include/linux/fs_struct.h
@@ -2,11 +2,12 @@
 #ifndef _LINUX_FS_STRUCT_H
 #define _LINUX_FS_STRUCT_H

-#include <linux/sched.h>
 #include <linux/path.h>
 #include <linux/spinlock.h>
 #include <linux/seqlock.h>

+struct task_struct;
+
 struct fs_struct {
        int users;
        seqlock_t seq;
@@ -42,9 +43,6 @@ static inline void get_fs_pwd(struct fs_struct *fs, struct path *pwd)

 extern bool current_chrooted(void);

-static inline int current_umask(void)
-{
-       return current->fs->umask;
-}
+#define current_umask() (current->fs->umask)

 #endif /* _LINUX_FS_STRUCT_H */

