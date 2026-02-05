Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3542556E
	for <audit@vger.kernel.org>; Thu,  5 Feb 2026 03:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770260618; cv=none; b=SZmzKTeo+kR7LcXQ6agxbV/Ae5g1AnHZocLA5vvIrVLrfx1LsC6VZrIQdQx6xQxAYfZFPpBJEiZPdjA1a1HFdZR/GQ+vEDQk0rGy7/ACgIS+g6h7dGPO/pereZLws0Z6KBPnxvePz1ArDCwg4wIgetK1ZFGXP9OBAedIuPV5cbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770260618; c=relaxed/simple;
	bh=YTuO9XOMYtQFSw91OdsurWUE3AwydW6ZsPKdxKOP4BQ=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=EHxGdMtfi5aUOwFtR92LARGGQcjilzewCKWLVCzGlSBW68bkFpGmp9irwEWBG5h3kYPyeO1hjdFYblL9/jFQIcTa43upZk9wcgYeOGekftMfuFtgBV5ngxQUItIYZpaj94J4pw/UyCak1Oh2OmfQdcq7YAHXB7nY7o0Q2SCdfmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=acAthcJw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="acAthcJw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770260617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IS3q9AjcgkzFfU3S4BSLVe3cPj6Y9pQ2xt5zDDWIl+Y=;
	b=acAthcJw276rVCFtV5yNJyJH1klcnLu5FMzl9fjsY1ZOQRIqsO+/Uy5iXAg7ckWkPuOfMp
	sxUV3wnqvih1sRo7i21lPmDAzIi6TlLU+cmdO0tHxzNeY95je3TNzv6vK0RekMJ4t8yCAR
	OFxY3YmWn47KnwP0j/mDuqdX8Qq+cVY=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-sVfG9YwfPJiZtRCREbIU8g-1; Wed, 04 Feb 2026 22:03:36 -0500
X-MC-Unique: sVfG9YwfPJiZtRCREbIU8g-1
X-Mimecast-MFC-AGG-ID: sVfG9YwfPJiZtRCREbIU8g_1770260616
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50148a2a5baso15699201cf.2
        for <audit@vger.kernel.org>; Wed, 04 Feb 2026 19:03:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770260615; x=1770865415;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IS3q9AjcgkzFfU3S4BSLVe3cPj6Y9pQ2xt5zDDWIl+Y=;
        b=cSU7rbcNDvS0XW7yfOwK0I4F7wtxlTLCZ7Tbf40cki5IBhlJOwImXEuo7ecZt5ipcD
         H2K88Z2ck/w9sxrEjt8iXTf+AblBnxKzuqPP4Y0oDDhL5mt2HLs9l7/teVeRkX7G+qty
         eUF3uUtCkAI5yrSIdR9ans+PNld51Hj1OpyXQz18/FtA1KHNsSFrxIHBxIrrOQNscoKj
         nLlBehjN0gyDWjQTCxmvA8jNyB3Q96bAEk4YqZyWV3Dv626s7PJlQAE7C2Sgq982zYeX
         ayb5Gay/zHyNF6SaICGekEDWs/CE67pAYGb06FauijxEqhaP5t29JfYcZbl06pRQtgWR
         6Shw==
X-Forwarded-Encrypted: i=1; AJvYcCVy1ScFpes1WAip5gNAp75aV9fUTd4hjMf10miNSgjB26S4hIkL14xkVM9apE5N4YMQnlKmQw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzVN85Kt3zBeHzyK6w9J985bCac9eSW2I1BN6mXFTrFjZDZRDL4
	T8D4G/uTjTHdBWaPduli0fa0JSFhqspFSoHYSs96QdO0XCjrtKHbketVRgB5EC0chJiKmG2vvQM
	/SONZZtGDIk/RIKyc0KISigjl0Ra0p+4avmEKz9S5jLhjB0x4NGT//BJxmILPMpcQ
X-Gm-Gg: AZuq6aJpuItFu+pOWG+Abe1B+XZXN0atMaQHS82JEnYuhDpHc5HH+CnqZ1MmZlp/rI3
	aXeOPAlp3GkX+0JMaY9iMdvrPEfdhINYwTUyFVLN9SH7Tz530mAdB2saOc+lNQymFDGzebMC36/
	QKF+DeGPgEyapjTNvAuka1ntF+wqwjGKR33bzt8/C+9bvZiSj/UogwYN8BqIdeDl2pXyfaQPD46
	sTwbTZkDNPIPWHltb1ltVMrJq4IeeBkN4dXVUGG5j5XtPR4v7O9rjR3IsTfq7GurFqoEZWgqE44
	GevRUvLgOpVs9QF+O/1wfeFGu1sdOzoUZM5qgiXCo0LR+PS6kaZyHozZFGWYbys7GcSe+sBMvx8
	lW9oJLN1XakPcRREImVmtYKgF21fH/HWG4th0LEcjc5qJrhrsHh4B6OJV
X-Received: by 2002:ac8:59d0:0:b0:4ee:441c:dfb2 with SMTP id d75a77b69052e-5061c15ec30mr58132551cf.32.1770260615624;
        Wed, 04 Feb 2026 19:03:35 -0800 (PST)
X-Received: by 2002:ac8:59d0:0:b0:4ee:441c:dfb2 with SMTP id d75a77b69052e-5061c15ec30mr58132361cf.32.1770260615239;
        Wed, 04 Feb 2026 19:03:35 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5061c213fcbsm29866831cf.32.2026.02.04.19.03.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Feb 2026 19:03:34 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <cbaab46e-715d-4d06-80af-320caec7feb7@redhat.com>
Date: Wed, 4 Feb 2026 22:03:33 -0500
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] audit: Avoid excessive dput/dget in audit_context
 setup and reset paths
To: Al Viro <viro@zeniv.linux.org.uk>, Waiman Long <llong@redhat.com>
Cc: Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
 Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org,
 audit@vger.kernel.org, Richard Guy Briggs <rgb@redhat.com>,
 Ricardo Robaina <rrobaina@redhat.com>
References: <20260203194433.1738162-1-longman@redhat.com>
 <20260203200505.GH3183987@ZenIV>
 <590a36e6-8d11-411a-8fcd-d93eef96f0e9@redhat.com>
 <20260203215002.GI3183987@ZenIV> <20260203232634.GJ3183987@ZenIV>
 <6661f966-5235-49ca-bf1f-d1ae2ae32f0d@redhat.com>
 <20260204062614.GK3183987@ZenIV>
 <46d5c480-87d0-4f6a-bcc2-6c936c87e216@redhat.com>
 <20260204201815.GP3183987@ZenIV>
In-Reply-To: <20260204201815.GP3183987@ZenIV>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IMlXzbeScXSeJT6tDh5bB1_vwO6XZNDToLLT3paqWFw_1770260616
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/4/26 3:18 PM, Al Viro wrote:
> On Wed, Feb 04, 2026 at 01:16:15PM -0500, Waiman Long wrote:
>
>
>> Thanks for the detailed explanation. I am thinking about something like
>> the code diff below. Of course, there are other corner cases like unshare(2)
>> that still needs to be handled. Do you think something like this is viable?
> Deadlocks aside, the immediate problem here is that consensus number is too
> low.  Take three threads sharing the same fs_struct instance.  The first one
> calls your get_fs_pwd_share(); then the remaining two threads call set_fs_pwd()
> (e.g. by calling chdir(2) in userland code).  The reference stored into
> fs->pwd_waiter by the first of those two gets overwritten by that stored
> by the second.  When the caller of get_fs_pwd_share() gets to put_fs_pwd_share(),
> only one of the sleepers gets woken up...
>
> And it's very easy to end up with something as simple as chdir("foo") deadlocking -
> we start with resolving the relative pathname we'd been given, audit wants to
> record the current directory, on the theory that relative pathname is none too
> useful in logs without knowing what had it been relative to.  Then, in the
> same thread, you call set_fs_pwd() - after all, that's the main effect of chdir(2).
> Deadlock...
>
> IOW, it's not just unshare(2) that needs to be taken care of - chdir(2) would need
> to be treated differently.

Now I realize that there is indeed a deadlock problem. Scrap that. Now I 
have a simpler idea that shouldn't have this type of deadlock problem. 
So what do you think about the sample code below?

Thanks,
Longman

=======================[ Cut here ]================================

diff --git a/fs/fs_struct.c b/fs/fs_struct.c
index b8c46c5a38a0..daeeb80cf088 100644
--- a/fs/fs_struct.c
+++ b/fs/fs_struct.c
@@ -32,15 +32,19 @@ void set_fs_root(struct fs_struct *fs, const struct 
path *p>
  void set_fs_pwd(struct fs_struct *fs, const struct path *path)
  {
         struct path old_pwd;
+       int xrefs;

         path_get(path);
         write_seqlock(&fs->seq);
         old_pwd = fs->pwd;
         fs->pwd = *path;
+       xrefs = fs->pwd_xrefs + 1;
+       fs->pwd_xrefs = 0;
         write_sequnlock(&fs->seq);

         if (old_pwd.dentry)
-               path_put(&old_pwd);
+               while (xrefs--)
+                       path_put(&old_pwd);
  }

  static inline int replace_path(struct path *p, const struct path *old, 
const s>
diff --git a/include/linux/fs_struct.h b/include/linux/fs_struct.h
index 0070764b790a..0d79d51de240 100644
--- a/include/linux/fs_struct.h
+++ b/include/linux/fs_struct.h
@@ -8,10 +8,11 @@
  #include <linux/seqlock.h>

  struct fs_struct {
-       int users;
         seqlock_t seq;
+       int users;
         int umask;
         int in_exec;
+       int pwd_xrefs;  /* Extra references of pwd */
         struct path root, pwd;
  } __randomize_layout;

@@ -40,6 +41,31 @@ static inline void get_fs_pwd(struct fs_struct *fs, 
struct p>
         read_sequnlock_excl(&fs->seq);
  }

+static inline void get_fs_pwd_share(struct fs_struct *fs, struct path *pwd)
+{
+       read_seqlock_excl(&fs->seq);
+       *pwd = fs->pwd;
+       if (fs->pwd_xrefs)
+               fs->pwd_xrefs--;
+       else
+               path_get(pwd);
+       read_sequnlock_excl(&fs->seq);
+}
+
+static inline void put_fs_pwd_share(struct fs_struct *fs, struct path *pwd)
+{
+       bool put = false;
+
+       read_seqlock_excl(&fs->seq);
+       if ((fs->pwd.dentry == pwd->dentry) && (fs->pwd.mnt == pwd->mnt))
+               fs->pwd_xrefs++;
+       else
+               put = true;
+       read_sequnlock_excl(&fs->seq);
+       if (put)
+               path_put(pwd);
+}
+
  extern bool current_chrooted(void);

  static inline int current_umask(void)

